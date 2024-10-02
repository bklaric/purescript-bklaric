module JavaScript.Web.DOM.HtmlElements.HtmlButtonElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlButtonElement :: Type

instance EventTarget HtmlButtonElement

instance Node HtmlButtonElement

instance Element HtmlButtonElement

instance HtmlElement HtmlButtonElement

readHtmlButtonElement :: forall object. object -> Maybe HtmlButtonElement
readHtmlButtonElement = unsafeReadProtoTagged "HTMLButtonElement"
