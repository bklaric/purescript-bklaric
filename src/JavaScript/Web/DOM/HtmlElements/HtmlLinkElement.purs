module JavaScript.Web.DOM.HtmlElements.HtmlLinkElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlLinkElement :: Type

instance EventTarget HtmlLinkElement

instance Node HtmlLinkElement

instance Element HtmlLinkElement

instance HtmlElement HtmlLinkElement

readHtmlLinkElement :: forall object. object -> Maybe HtmlLinkElement
readHtmlLinkElement = unsafeReadProtoTagged "HTMLLinkElement"

foreign import href :: HtmlLinkElement -> Effect String
foreign import setHref :: String -> HtmlLinkElement -> Effect Unit

foreign import type_ :: HtmlLinkElement -> Effect String
foreign import setType :: String -> HtmlLinkElement -> Effect Unit

foreign import rel :: HtmlLinkElement -> Effect String
foreign import setRel :: String -> HtmlLinkElement -> Effect Unit
