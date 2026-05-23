module JavaScript.Web.DOM.HtmlElements.HtmlSelectElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlSelectElement :: Type

instance EventTarget HtmlSelectElement

instance Node HtmlSelectElement

instance Element HtmlSelectElement

instance HtmlElement HtmlSelectElement

readHtmlSelectElement :: forall object. object -> Maybe HtmlSelectElement
readHtmlSelectElement = unsafeReadProtoTagged "HTMLSelectElement"

foreign import value :: HtmlSelectElement -> Effect String
foreign import setValue :: String -> HtmlSelectElement -> Effect Unit
