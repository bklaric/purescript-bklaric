module JavaScript.Web.SVG.SVGElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class Node)
import JavaScript.Web.DOM.CssStyleDeclaration (CssStyleDeclaration)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)
import JavaScript.Web.SVG.Class (class SVGElement)
import Unsafe.Coerce (unsafeCoerce)

foreign import data SVGElement :: Type

instance EventTarget SVGElement
instance Node SVGElement
instance Element SVGElement
instance SVGElement SVGElement

toSVGElement :: forall svgElement. SVGElement svgElement => svgElement -> SVGElement
toSVGElement = unsafeCoerce

readSVGElement :: forall object. object -> Maybe SVGElement
readSVGElement = unsafeReadProtoTagged "SVGElement"

foreign import _style :: forall svgElement. svgElement -> Effect CssStyleDeclaration
foreign import _setStyle :: forall svgElement. String -> svgElement -> Effect Unit

style :: forall svgElement. SVGElement svgElement => svgElement -> Effect CssStyleDeclaration
style = _style

setStyle :: forall svgElement. SVGElement svgElement => String -> svgElement -> Effect Unit
setStyle = _setStyle
