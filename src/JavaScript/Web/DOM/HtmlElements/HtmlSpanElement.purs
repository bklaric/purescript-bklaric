module JavaScript.Web.DOM.HtmlElements.HtmlSpanElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlSpanElement :: Type

instance EventTarget HtmlSpanElement

instance Node HtmlSpanElement

instance Element HtmlSpanElement

instance HtmlElement HtmlSpanElement

readHtmlSpanElement :: forall object. object -> Maybe HtmlSpanElement
readHtmlSpanElement = unsafeReadProtoTagged "HTMLSpanElement"
