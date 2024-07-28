module JavaScript.Web.DOM.HtmlElements.HtmlInputElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, setStyleDefault, styleDefault)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlInputElement :: Type

instance EventTarget HtmlInputElement

instance Node HtmlInputElement

instance Element HtmlInputElement

instance HtmlElement HtmlInputElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault
    setStyle = setStyleDefault

readHtmlInputElement :: forall object. object -> Maybe HtmlInputElement
readHtmlInputElement = unsafeReadProtoTagged "HTMLInputElement"

foreign import value :: HtmlInputElement -> Effect String
foreign import setValue :: String -> HtmlInputElement -> Effect Unit
