module JavaScript.Web.DOM.ElementType where

import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.Node (class Node)

-- Element type is in a separate file to untangle circular dependencies.
foreign import data Element :: Type

instance EventTarget Element
instance Node Element
instance Element Element
