module JavaScript.Web.DOM.Class.EventTarget where

import JavaScript.Web.DOM.Element (Element)

class EventTarget (eventTarget :: Type)

instance EventTarget Element
