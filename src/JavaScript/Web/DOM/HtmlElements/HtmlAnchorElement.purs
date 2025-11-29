module JavaScript.Web.DOM.HtmlElements.HtmlAnchorElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlAnchorElement :: Type

instance EventTarget HtmlAnchorElement

instance Node HtmlAnchorElement

instance Element HtmlAnchorElement

instance HtmlElement HtmlAnchorElement

readHtmlAnchorElement :: forall object. object -> Maybe HtmlAnchorElement
readHtmlAnchorElement = unsafeReadProtoTagged "HTMLAnchorElement"

foreign import href :: HtmlAnchorElement -> Effect String
foreign import setHref :: String -> HtmlAnchorElement -> Effect Unit
