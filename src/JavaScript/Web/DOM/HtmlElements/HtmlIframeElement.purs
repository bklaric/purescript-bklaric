module JavaScript.Web.DOM.HtmlElements.HTMLIFrameElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, setStyleDefault, styleDefault)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlIframeElement :: Type

instance EventTarget HtmlIframeElement

instance Node HtmlIframeElement

instance Element HtmlIframeElement

instance HtmlElement HtmlIframeElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault
    setStyle = setStyleDefault

readHtmlIframeElement :: forall object. object -> Maybe HtmlIframeElement
readHtmlIframeElement = unsafeReadProtoTagged "HTMLIframeElement"

foreign import src :: HtmlIframeElement -> Effect String
foreign import setSrc :: String -> HtmlIframeElement -> Effect Unit
