module Perun.Async.Server (run, run_) where

import Prelude

import Async (Async, runSafeAsync)
import Effect (Effect)
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Net.Server (IpcListenOptions, TcpListenOptions)
import Perun.Request (Request)
import Perun.Response (Response)
import Perun.Server (RequestHandler)
import Perun.Server as Perun
import Untagged.Union (class InOneOf)

fromAsync :: (Request -> (∀ left. Async left Response)) -> RequestHandler
fromAsync handler = \request respond ->
    runSafeAsync respond (handler request)

run
    :: forall options
    .  InOneOf options TcpListenOptions IpcListenOptions
    => options
    -> Effect Unit
    -> (Error -> Effect Unit)
    -> (Error -> Effect Unit)
    -> (Request -> (∀ left. Async left Response))
    -> Effect Unit
run listenOptions onListening onRequestError onResponseError handler =
    Perun.run
        listenOptions
        onListening
        onRequestError
        onResponseError
        (fromAsync handler)

run_
    :: forall options
    .  InOneOf options TcpListenOptions IpcListenOptions
    => options
    -> (Request -> (∀ left. Async left Response))
    -> Effect Unit
run_ listenOptions handler = Perun.run_ listenOptions (fromAsync handler)
