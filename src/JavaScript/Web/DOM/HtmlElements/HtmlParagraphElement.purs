module JavaScript.Web.DOM.HtmlElements.HtmlParagraphElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlParagraphElement :: Type

instance EventTarget HtmlParagraphElement

instance Node HtmlParagraphElement

instance Element HtmlParagraphElement

instance HtmlElement HtmlParagraphElement

readHtmlParagraphElement :: forall object. object -> Maybe HtmlParagraphElement
readHtmlParagraphElement = unsafeReadProtoTagged "HTMLParagraphElement"
