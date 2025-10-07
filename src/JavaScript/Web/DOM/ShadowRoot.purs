module JavaScript.Web.DOM.ShadowRoot where

import JavaScript.Web.DOM.Class (class DocumentFragment, class EventTarget, class Node)

-- https://developer.mozilla.org/en-US/docs/Web/API/ShadowRoot

foreign import data ShadowRoot :: Type

instance EventTarget ShadowRoot

instance Node ShadowRoot

instance DocumentFragment ShadowRoot
