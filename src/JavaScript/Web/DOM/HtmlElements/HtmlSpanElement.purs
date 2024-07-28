module JavaScript.Web.DOM.HtmlElements.HtmlSpanElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, setStyleDefault, styleDefault)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlSpanElement :: Type

instance EventTarget HtmlSpanElement

instance Node HtmlSpanElement

instance Element HtmlSpanElement

instance HtmlElement HtmlSpanElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault
    setStyle = setStyleDefault

readHtmlSpanElement :: forall object. object -> Maybe HtmlSpanElement
readHtmlSpanElement = unsafeReadProtoTagged "HTMLSpanElement"
