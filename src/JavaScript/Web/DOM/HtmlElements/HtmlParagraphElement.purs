module JavaScript.Web.DOM.HtmlElements.HtmlParagraphElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlParagraphElement :: Type

instance EventTarget HtmlParagraphElement

instance Node HtmlParagraphElement

instance Element HtmlParagraphElement

instance HtmlElement HtmlParagraphElement

readHtmlParagraphElement :: forall object. object -> Maybe HtmlParagraphElement
readHtmlParagraphElement = unsafeReadProtoTagged "HTMLParagraphElement"
