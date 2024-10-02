module JavaScript.Web.DOM.HtmlElements.HtmlDivElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlDivElement :: Type

instance EventTarget HtmlDivElement

instance Node HtmlDivElement

instance Element HtmlDivElement

instance HtmlElement HtmlDivElement

readHtmlDivElement :: forall object. object -> Maybe HtmlDivElement
readHtmlDivElement = unsafeReadProtoTagged "HTMLDivElement"
