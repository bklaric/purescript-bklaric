module Perun.Server (RequestHandler, create, create_, run, run_) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Events.EventEmitter (on)
import JavaScript.Node.Events.EventListener (toEventListener)
import JavaScript.Node.Http.IncomingMessage as IncomingMessage
import JavaScript.Node.Http.Server (Server, createServer_C')
import JavaScript.Node.Http.ServerResponse as ServerResponse
import JavaScript.Node.Net.Server (IpcListenOptions, TcpListenOptions, listen)
import Perun.Request (Request, readRequest)
import Perun.Response (Response, respond)
import Untagged.Union (class InOneOf)

type RequestHandler = Request -> (Response -> Effect Unit) -> Effect Unit

-- | A request and its response each emit `error` rather than throwing, and an
-- | unhandled `error` takes the process down, so both listeners are attached
-- | before the handler runs.
create
    :: (Error -> Effect Unit)
    -> (Error -> Effect Unit)
    -> RequestHandler
    -> Effect Server
create requestErrorHandler responseErrorHandler handler =
    createServer_C' \request response -> do
        request
            # on IncomingMessage.error (toEventListener requestErrorHandler)
            # void
        response
            # on ServerResponse.error (toEventListener responseErrorHandler)
            # void
        handler (readRequest request) (respond response)

create_ :: RequestHandler -> Effect Server
create_ handler = create (const mempty) (const mempty) handler

run
    :: forall options
    .  InOneOf options TcpListenOptions IpcListenOptions
    => options
    -> Effect Unit
    -> (Error -> Effect Unit)
    -> (Error -> Effect Unit)
    -> RequestHandler
    -> Effect Unit
run listenOptions onListening onRequestError onResponseError handler = do
    server <- create onRequestError onResponseError handler
    server # listen listenOptions onListening # void

run_ :: forall options. InOneOf options TcpListenOptions IpcListenOptions =>
    options -> RequestHandler -> Effect Unit
run_ listenOptions handler = run listenOptions mempty mempty mempty handler
