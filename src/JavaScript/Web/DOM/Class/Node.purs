module JavaScript.Web.DOM.Class.Node where

import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Element (Element)

class EventTarget node <= Node node

instance Node Element
