module JavaScript.DOM.Class.EventTarget where

import JavaScript.DOM.Element (Element)

class EventTarget (eventTarget :: Type)

instance EventTarget Element
