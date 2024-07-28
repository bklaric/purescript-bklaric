module JavaScript.Web.DOM.HtmlElements.HtmlBodyElement where

import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement)
import JavaScript.Web.DOM.Class.Node (class Node)

foreign import data HtmlBodyElement :: Type

instance EventTarget HtmlBodyElement

instance Node HtmlBodyElement

instance Element HtmlBodyElement

instance HtmlElement HtmlBodyElement
