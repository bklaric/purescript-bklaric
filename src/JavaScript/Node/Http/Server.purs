module JavaScript.Node.Http.Server
    ( Server
    , createServerOC
    , createServerOC'
    , createServerO_
    , createServer_C
    , createServer_C'
    , createServer__
    ) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import JavaScript.Node.Events.EventListener (EventListener, toEventListener)
import JavaScript.Node.Http.IncomingMessage (IncomingMessage)
import JavaScript.Node.Http.ServerResponse (ServerResponse)
import JavaScript.Node.Net.Server (class Server)
import Undefined (undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

-- https://nodejs.org/api/http.html

foreign import data Server :: Type

-- createServer

type CreateServerOptions =
    { connectionsCheckingInterval :: UndefinedOr Int
    , keepAlive :: UndefinedOr Boolean
    -- Many more.
    }

foreign import createServerImpl ::
    CreateServerOptions -> EventListener (IncomingMessage -> ServerResponse -> Effect Unit) -> Effect Server

createServerOC :: forall options. Castable options CreateServerOptions =>
    options -> EventListener (IncomingMessage -> ServerResponse -> Effect Unit) -> Effect Server
createServerOC options callback =
    createServerImpl (cast options) callback

createServerOC' :: forall options. Castable options CreateServerOptions =>
    options -> (IncomingMessage -> ServerResponse -> Effect Unit) -> Effect Server
createServerOC' options callback = createServerOC options (toEventListener callback)

createServerO_ :: forall options. Castable options CreateServerOptions =>
    options -> Effect Server
createServerO_ options = createServerImpl (cast options) undefined

createServer_C :: EventListener (IncomingMessage -> ServerResponse -> Effect Unit) -> Effect Server
createServer_C callback = createServerImpl undefined callback

createServer_C' :: (IncomingMessage -> ServerResponse -> Effect Unit) -> Effect Server
createServer_C' callback = createServer_C (toEventListener callback)

createServer__ :: Effect Server
createServer__ = createServerImpl undefined undefined

instance EventEmitter Server where
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

instance Server Server
