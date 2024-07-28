module JavaScript.Web.DOM.HtmlElements.HtmlImageElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, setStyleDefault, styleDefault)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlImageElement :: Type

instance EventTarget HtmlImageElement

instance Node HtmlImageElement

instance Element HtmlImageElement

instance HtmlElement HtmlImageElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault
    setStyle = setStyleDefault

readHtmlImageElement :: forall object. object -> Maybe HtmlImageElement
readHtmlImageElement = unsafeReadProtoTagged "HTMLImageElement"

foreign import width :: HtmlImageElement -> Effect Int
foreign import setWidth :: Int -> HtmlImageElement -> Effect Unit

foreign import height :: HtmlImageElement -> Effect Int
foreign import setHeight :: Int -> HtmlImageElement -> Effect Unit

foreign import naturalWidth :: HtmlImageElement -> Effect Int
foreign import naturalHeight :: HtmlImageElement -> Effect Int

foreign import src :: HtmlImageElement -> Effect String
foreign import setSrc :: String -> HtmlImageElement -> Effect Unit

foreign import complete :: HtmlImageElement -> Effect Boolean
