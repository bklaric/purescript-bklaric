module JavaScript.Web.DOM.Events.TouchEvent where

import JavaScript.Web.DOM.Class (class Event, class UiEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data TouchEvent :: Type

instance Event TouchEvent
instance UiEvent TouchEvent

touchstart :: EventType TouchEvent
touchstart = EventType "touchstart"

touchend :: EventType TouchEvent
touchend = EventType "touchend"

touchmove :: EventType TouchEvent
touchmove = EventType "touchmove"

touchcancel :: EventType TouchEvent
touchcancel = EventType "touchcancel"
