module JavaScript.Web.DOM.HtmlElements.HtmlButtonElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, setStyleDefault, styleDefault)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlButtonElement :: Type

instance EventTarget HtmlButtonElement

instance Node HtmlButtonElement

instance Element HtmlButtonElement

instance HtmlElement HtmlButtonElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault
    setStyle = setStyleDefault

readHtmlButtonElement :: forall object. object -> Maybe HtmlButtonElement
readHtmlButtonElement = unsafeReadProtoTagged "HTMLButtonElement"
