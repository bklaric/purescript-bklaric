-- https://developer.mozilla.org/en-US/docs/Web/API/ResizeObserver
module JavaScript.Web.DOM.ResizeObserver
  ( ResizeObserver
  , new
  , observe
  , unobserve
  , disconnect
  ) where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element)

foreign import data ResizeObserver :: Type

-- | The callback gets the observer, not the entries: read the sizes off the elements.
foreign import new :: (ResizeObserver -> Effect Unit) -> Effect ResizeObserver

foreign import _observe :: forall element. element -> ResizeObserver -> Effect Unit

foreign import _unobserve :: forall element. element -> ResizeObserver -> Effect Unit

foreign import disconnect :: ResizeObserver -> Effect Unit

observe :: forall element. Element element => element -> ResizeObserver -> Effect Unit
observe = _observe

unobserve :: forall element. Element element => element -> ResizeObserver -> Effect Unit
unobserve = _unobserve
