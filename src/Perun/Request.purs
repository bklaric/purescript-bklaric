module Perun.Request where

import Prelude

import Control.Monad.Except (runExcept)
import Data.Array (mapMaybe)
import Data.Bifunctor (lmap)
import Data.Either (Either, hush)
import Data.Either.Swap (swap)
import Data.HTTP.Method (CustomMethod, Method, fromString)
import Data.List (List)
import Data.Map (Map, empty, fromFoldable)
import Data.Maybe (Maybe(..), fromJust, fromMaybe, maybe)
import Data.String (Pattern(..), split)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..))
import Foreign (Foreign, readString)
import Foreign.Object (lookup, toUnfoldable)
import JavaScript.Node.Http.IncomingMessage (IncomingMessage, headers, method, url)
import Partial.Unsafe (unsafePartial)
import Perun.Request.Body (Body, fromRequest)
import Perun.Url (Url, parseUrl, pathSegments, queryPairs)
import URI.Extra.QueryPairs (Key, QueryPairs, Value)
import URI.Path.Segment (PathSegment)

type Request =
    { method :: Either CustomMethod Method
    , path :: List PathSegment
    , query :: QueryPairs Key Value
    , headers :: Map String String
    , cookies :: Map String String
    , body :: Body
    }

-- IncomingMessage models both a server request and a client response, so it
-- types `method` and `url` as optional even though a server request always
-- carries both. Absence collapses to the empty string, which fails to parse as
-- a method or a url and so routes to the same error a malformed one would.

readMethod :: IncomingMessage -> Either CustomMethod Method
readMethod request = request # method # fromMaybe "" # fromString # swap

readUrl :: IncomingMessage -> Either String Url
readUrl request = let
    requestUrl = url request # fromMaybe ""
    in
    requestUrl # parseUrl # lmap (const requestUrl)

readString' ∷ Foreign → Maybe String
readString' = readString >>> runExcept >>> hush

readHeaders :: IncomingMessage -> Map String String
readHeaders request =
    headers request
    # toUnfoldable
    # mapMaybe (traverse readString')
    # fromFoldable

parseCookies :: String -> Array (Tuple String String)
parseCookies string =
    split (Pattern "; ") string
    <#> split (Pattern "=")
    # mapMaybe case _ of
        [name, value] -> Just $ Tuple name value
        _ -> Nothing

readCookies :: IncomingMessage -> Map String String
readCookies request =
    headers request
    # lookup "cookie"
    >>= readString'
    # maybe empty (parseCookies >>> fromFoldable)

readRequest :: IncomingMessage -> Request
readRequest request = let
    url' = unsafePartial (readUrl request # hush # fromJust)
    in
    { method: readMethod request
    , path: pathSegments url'
    , query: queryPairs url'
    , headers: readHeaders request
    , cookies: readCookies request
    , body: fromRequest request
    }
