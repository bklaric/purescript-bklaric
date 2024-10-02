module JavaScript.Web.DOM.HtmlElements.HtmlInputElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlInputElement :: Type

instance EventTarget HtmlInputElement

instance Node HtmlInputElement

instance Element HtmlInputElement

instance HtmlElement HtmlInputElement

readHtmlInputElement :: forall object. object -> Maybe HtmlInputElement
readHtmlInputElement = unsafeReadProtoTagged "HTMLInputElement"

foreign import value :: HtmlInputElement -> Effect String
foreign import setValue :: String -> HtmlInputElement -> Effect Unit
