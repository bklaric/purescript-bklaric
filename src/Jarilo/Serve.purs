module Jarilo.Serve (Rejection, ServeOptions, serve) where

import Prelude

import Async (runAsync)
import Data.Array.NonEmpty (nubEq, toArray)
import Data.Either (Either(..))
import Data.HTTP.Method as Method
import Data.Maybe (Maybe(..), fromMaybe)
import Data.MultiMap (MultiMap, singleton')
import Data.String (joinWith)
import Effect (Effect)
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Events.EventEmitter (on)
import JavaScript.Node.Events.EventListener (toEventListener)
import JavaScript.Node.Http.IncomingMessage (IncomingMessage)
import JavaScript.Node.Http.IncomingMessage as IncomingMessage
import JavaScript.Node.Http.Server (createServer_C')
import JavaScript.Node.Http.ServerResponse (ServerResponse)
import JavaScript.Node.Http.ServerResponse as ServerResponse
import JavaScript.Node.Net.Server (IpcListenOptions, TcpListenOptions, listen)
import Jarilo.Router.Junction (class JunctionRouter, junctionRouter)
import Jarilo.Router.Request (requestErrorMessage, requestErrorStatus)
import Jarilo.Router.Route (RouteMatch(..))
import Jarilo.Server.Request (readRequest)
import Jarilo.Server.Response (respond)
import Type.Proxy (Proxy)
import Untagged.Union (class InOneOf)

-- | A request the server answered itself, because no handler could take it.
type Rejection =
    { method :: String
    , url :: String
    , statusCode :: Int
    , reason :: String
    }

-- | A request and its response each emit `error` rather than throwing, and an
-- | unhandled `error` takes the process down, so `onStreamError` listens on both
-- | of every request.
type ServeOptions listenOptions =
    { listen :: listenOptions
    , onRejected :: Rejection -> Effect Unit
    , onStreamError :: Error -> Effect Unit
    }

reject
    :: (Rejection -> Effect Unit)
    -> IncomingMessage
    -> ServerResponse
    -> Int
    -> MultiMap String String
    -> String
    -> Effect Unit
reject onRejected message response statusCode headers reason = do
    onRejected
        { method: IncomingMessage.method message # fromMaybe ""
        , url: IncomingMessage.url message # fromMaybe ""
        , statusCode
        , reason
        }
    respond response { statusCode, headers, body: "" }

serve
    :: ∀ junction handlers listenOptions
    .  JunctionRouter junction handlers
    => InOneOf listenOptions TcpListenOptions IpcListenOptions
    => Proxy junction
    -> ServeOptions listenOptions
    -> Record handlers
    -> Effect Unit
serve proxy { listen: listenOptions, onRejected, onStreamError } handlers = do
    server <- createServer_C' \message response -> do
        message # on IncomingMessage.error (toEventListener onStreamError) # void
        response # on ServerResponse.error (toEventListener onStreamError) # void
        let reject' = reject onRejected message response
        case readRequest message of
            Nothing ->
                reject' 400 mempty "The request target isn't a path with an optional query, or doesn't decode."
            Just request -> case junctionRouter proxy handlers request of
                Unmatched ->
                    reject' 404 mempty "No route has this path."
                PathMatched methods -> let
                    allowed = methods # nubEq # toArray <#> Method.print # joinWith ", "
                    in
                    reject' 405 (singleton' "Allow" allowed)
                        ("This path takes only " <> allowed <> ".")
                Matched routed -> routed # runAsync case _ of
                    Left error -> reject' (requestErrorStatus error) mempty $ requestErrorMessage error
                    Right routedResponse -> respond response routedResponse
    server # listen listenOptions (pure unit) # void
