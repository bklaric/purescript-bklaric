module JavaScript.Web.DOM.AbortSignal (AbortSignal, timeout) where

import Effect (Effect)

-- https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal

foreign import data AbortSignal :: Type

-- A signal that aborts on its own after the given number of milliseconds. Pass
-- it as a RequestInit's signal to bound a fetch, which otherwise waits out the
-- runtime's own (very generous) defaults.
-- https://developer.mozilla.org/en-US/docs/Web/API/AbortSignal/timeout_static
foreign import timeout :: Int -> Effect AbortSignal
