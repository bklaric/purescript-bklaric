module JavaScript.Web.DOM.HtmlElements.HtmlFormElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlFormElement :: Type

instance EventTarget HtmlFormElement

instance Node HtmlFormElement

instance Element HtmlFormElement

instance HtmlElement HtmlFormElement

readHtmlFormElement :: forall object. object -> Maybe HtmlFormElement
readHtmlFormElement = unsafeReadProtoTagged "HTMLFormElement"

foreign import submit :: HtmlFormElement -> Effect Unit
