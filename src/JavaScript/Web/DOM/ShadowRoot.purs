module JavaScript.Web.DOM.ShadowRoot (ShadowRoot, elementFromPoint) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class DocumentFragment, class EventTarget, class Node)
import JavaScript.Web.DOM.ElementType (Element)

-- https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot

foreign import data ShadowRoot :: Type

instance EventTarget ShadowRoot

instance Node ShadowRoot

instance DocumentFragment ShadowRoot

foreign import _elementFromPoint :: Int -> Int -> ShadowRoot -> Effect (Nullable Element)

-- | The topmost element at the given viewport (client) coordinates, as seen from inside this
-- | root: an element in it rather than the host `Document.elementFromPoint` would stop at.
-- | `Nothing` if the point is outside the viewport.
elementFromPoint :: Int -> Int -> ShadowRoot -> Effect (Maybe Element)
elementFromPoint x y root = _elementFromPoint x y root <#> toMaybe
