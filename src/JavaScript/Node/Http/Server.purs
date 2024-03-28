module JavaScript.Node.Http.Server
    ( HttpServer
    , create
    , create_
    ) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Events.EventEmitter (class EventEmitter, on)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import JavaScript.Node.Events.EventListener (toEventListener)
import JavaScript.Node.Http.IncomingMessage as IncomingMessage
import JavaScript.Node.Http.Server.Request (Request)
import JavaScript.Node.Http.Server.Response (Response)
import JavaScript.Node.Http.Server.Response as Response
import JavaScript.Node.Server (class Server, defaultListen)

foreign import data HttpServer :: Type

foreign import createImpl ::
    (Request -> Response -> Effect Unit) -> Effect HttpServer

create
    :: (Error -> Effect Unit)
    -> (Error -> Effect Unit)
    -> (Request -> Response -> Effect Unit)
    -> Effect HttpServer
create requestErrorListener responseErrorListener callback =
    createImpl \request response -> let
        requestErrorListener' = toEventListener requestErrorListener
        responseErrorListener' = toEventListener responseErrorListener
        in do
        request # on IncomingMessage.error requestErrorListener' # void
        response # on Response.error responseErrorListener' # void
        callback request response

create_ :: (Request -> Response -> Effect Unit) -> Effect HttpServer
create_ callback = create mempty mempty callback

instance EventEmitter HttpServer where
    on                  = EventEmitter.defaultOn
    once                = EventEmitter.defaultOnce
    prependListener     = EventEmitter.defaultPrependListener
    prependOnceListener = EventEmitter.defaultPrependOnceListener
    removeListener      = EventEmitter.defaultRemoveListener
    removeAllListeners  = EventEmitter.defaultRemoveAllListeners
    emit                = EventEmitter.defaultEmit
    listeners           = EventEmitter.defaultListeners
    listenerCount       = EventEmitter.defaultListenerCount
    getMaxListeners     = EventEmitter.defaultGetMaxListeners
    setMaxListeners     = EventEmitter.defaultSetMaxListeners
    eventNames          = EventEmitter.defaultEventNames

instance Server HttpServer where
    listen = defaultListen
