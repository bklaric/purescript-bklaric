module JavaScript.Web.DOM.HtmlElements.HtmlBodyElement where

import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)

foreign import data HtmlBodyElement :: Type

instance EventTarget HtmlBodyElement

instance Node HtmlBodyElement

instance Element HtmlBodyElement

instance HtmlElement HtmlBodyElement
