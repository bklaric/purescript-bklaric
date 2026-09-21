-- | The routes both specs run against, served in-process by Jarilo itself.
module Test.Jarilo.Routes
    ( DeleteThing
    , Echo
    , EchoBody
    , Thing
    , ThingBody
    , origin
    , serveRoutes
    ) where

import Prelude

import Data.Map as Map
import Data.Maybe (fromMaybe)
import Effect (Effect)
import Effect.Ref (Ref)
import Effect.Ref as Ref
import Jarilo (type (!), type (&), type (/), type (:), type (<|>), type (==>), Capture, Delete_, Get, Literal, Mandatory, Many, NoContent, NotFound_, OkJson, PostJson_, noContent_, notFound__, ok_)
import Jarilo.Serve (Rejection, serve)
import Type.Proxy (Proxy(..))

type ThingBody =
    { name :: String
    , count :: Int
    , tags :: Array String
    , session :: String
    }

type Thing =
    Get (Literal "things" / Capture "name" String) (Mandatory "count" Int & Many "tag" String)
    ==> OkJson ThingBody ! NotFound_

-- Shares Thing's path, so a third method on it is answered with both.
type DeleteThing = Delete_ (Literal "things" / Capture "name" String) ==> NoContent

-- Answers with headers the request came with, which is how a spec sees what a
-- fetch sent.
type EchoBody = { text :: String, contentType :: String, probe :: String }

type Echo = PostJson_ (Literal "echo") { text :: String } ==> OkJson EchoBody

type Routes = "thing" : Thing <|> "deleteThing" : DeleteThing <|> "echo" : Echo

port :: Int
port = 8931

origin :: String
origin = "http://localhost:" <> show port

-- | Every request the server answers itself is appended to the ref, so a spec
-- | can check what it was told.
serveRoutes :: Ref (Array Rejection) -> Effect Unit
serveRoutes rejections = serve (Proxy :: _ Routes)
    { listen: { port }
    , onRejected: \rejection -> Ref.modify_ (_ <> [ rejection ]) rejections
    , onStreamError: const $ pure unit
    }
    { thing: \{ path: { name }, query: { count, tag }, cookies } -> pure
        if name == "missing"
        then notFound__
        else ok_
            { name
            , count
            , tags: tag
            , session: Map.lookup "session" cookies # fromMaybe ""
            }
    , deleteThing: const $ pure noContent_
    , echo: \{ body: { text }, headers } -> pure $ ok_
        { text
        , contentType: Map.lookup "content-type" headers # fromMaybe ""
        , probe: Map.lookup "x-probe" headers # fromMaybe ""
        }
    }
