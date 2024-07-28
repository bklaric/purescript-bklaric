module JavaScript.Web.DOM.HtmlElements.HtmlHeadElement where

import Data.Maybe (Maybe)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlHeadElement :: Type

instance EventTarget HtmlHeadElement

instance Node HtmlHeadElement

instance Element HtmlHeadElement

instance HtmlElement HtmlHeadElement

readHtmlHeadElement :: forall object. object -> Maybe HtmlHeadElement
readHtmlHeadElement = unsafeReadProtoTagged "HTMLHeadElement"
