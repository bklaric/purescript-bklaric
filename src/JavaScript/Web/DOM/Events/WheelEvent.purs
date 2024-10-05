module JavaScript.Web.DOM.Events.WheelEvent where

import JavaScript.Web.DOM.Class (class Event, class MouseEvent, class UiEvent)
import JavaScript.Web.DOM.Class.WheelEvent (class WheelEvent, deltaXDefault, deltaYDefault, deltaZDefault)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data WheelEvent :: Type

instance Event WheelEvent
instance UiEvent WheelEvent
instance MouseEvent WheelEvent

instance WheelEvent WheelEvent where
    deltaX = deltaXDefault
    deltaY = deltaYDefault
    deltaZ = deltaZDefault

wheel :: EventType WheelEvent
wheel = EventType "wheel"
