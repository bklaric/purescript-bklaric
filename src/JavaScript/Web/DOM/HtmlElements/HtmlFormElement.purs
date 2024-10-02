module JavaScript.Web.DOM.HtmlElements.HtmlFormElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlFormElement :: Type

instance EventTarget HtmlFormElement

instance Node HtmlFormElement

instance Element HtmlFormElement

instance HtmlElement HtmlFormElement

readHtmlFormElement :: forall object. object -> Maybe HtmlFormElement
readHtmlFormElement = unsafeReadProtoTagged "HTMLFormElement"

foreign import submit :: HtmlFormElement -> Effect Unit
