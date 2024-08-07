module JavaScript.Web.DOM.HtmlElements.HtmlDivElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlDivElement :: Type

instance EventTarget HtmlDivElement

instance Node HtmlDivElement

instance Element HtmlDivElement

instance HtmlElement HtmlDivElement

readHtmlDivElement :: forall object. object -> Maybe HtmlDivElement
readHtmlDivElement = unsafeReadProtoTagged "HTMLDivElement"
