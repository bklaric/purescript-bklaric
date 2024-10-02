module JavaScript.Web.DOM.HtmlElements.HtmlHeadElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlHeadElement :: Type

instance EventTarget HtmlHeadElement

instance Node HtmlHeadElement

instance Element HtmlHeadElement

instance HtmlElement HtmlHeadElement

readHtmlHeadElement :: forall object. object -> Maybe HtmlHeadElement
readHtmlHeadElement = unsafeReadProtoTagged "HTMLHeadElement"
