module JavaScript.Web.DOM.HtmlElements.HtmlElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.CssStyleDeclaration (CssStyleDeclaration)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)
import Unsafe.Coerce (unsafeCoerce)

foreign import data HtmlElement :: Type

instance EventTarget HtmlElement
instance Node HtmlElement
instance Element HtmlElement
instance HtmlElement HtmlElement

toHtmlElement :: forall htmlElement. HtmlElement htmlElement => htmlElement -> HtmlElement
toHtmlElement = unsafeCoerce

readHtmlElement :: forall object. object -> Maybe HtmlElement
readHtmlElement = unsafeReadProtoTagged "HTMLElement"

foreign import _offsetWidth :: forall htmlElement. htmlElement -> Effect Int
foreign import _offsetHeight :: forall htmlElement. htmlElement -> Effect Int
foreign import _style :: forall htmlElement. htmlElement -> Effect CssStyleDeclaration
foreign import _setStyle :: forall htmlElement. String -> htmlElement -> Effect Unit
foreign import _click :: forall htmlElement. htmlElement -> Effect Unit

offsetWidth :: forall htmlElement. HtmlElement htmlElement => htmlElement -> Effect Int
offsetWidth = _offsetWidth

offsetHeight :: forall htmlElement. HtmlElement htmlElement => htmlElement -> Effect Int
offsetHeight = _offsetHeight

style :: forall htmlElement. HtmlElement htmlElement => htmlElement -> Effect CssStyleDeclaration
style = _style

setStyle :: forall htmlElement. HtmlElement htmlElement => String -> htmlElement -> Effect Unit
setStyle = _setStyle

click :: forall htmlElement. HtmlElement htmlElement => htmlElement -> Effect Unit
click = _click
