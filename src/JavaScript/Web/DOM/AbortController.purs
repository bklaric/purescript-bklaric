module JavaScript.Web.DOM.AbortController (AbortController, abort, new, signal) where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.AbortSignal (AbortSignal)

-- https://developer.mozilla.org/en-US/docs/Web/API/AbortController

foreign import data AbortController :: Type

foreign import new :: Effect AbortController

-- Pure: a controller hands out the same signal for its whole lifetime.
foreign import signal :: AbortController -> AbortSignal

foreign import abort :: AbortController -> Effect Unit
