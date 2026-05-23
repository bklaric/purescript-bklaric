module JavaScript.Web.DOM.HtmlElements.HtmlOptionElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlOptionElement :: Type

instance EventTarget HtmlOptionElement

instance Node HtmlOptionElement

instance Element HtmlOptionElement

instance HtmlElement HtmlOptionElement

readHtmlOptionElement :: forall object. object -> Maybe HtmlOptionElement
readHtmlOptionElement = unsafeReadProtoTagged "HTMLOptionElement"
