module JavaScript.Web.DOM.Events.WheelEvent where

import JavaScript.Web.DOM.Class (class Event, class MouseEvent, class UiEvent, class WheelEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data WheelEvent :: Type

instance Event WheelEvent
instance UiEvent WheelEvent
instance MouseEvent WheelEvent
instance WheelEvent WheelEvent

foreign import _deltaX :: forall event. event -> Number
foreign import _deltaY :: forall event. event -> Number
foreign import _deltaZ :: forall event. event -> Number
foreign import _deltaMode :: forall event. event -> Int

deltaX :: forall wheelEvent. WheelEvent wheelEvent => wheelEvent -> Number
deltaX = _deltaX

deltaY :: forall wheelEvent. WheelEvent wheelEvent => wheelEvent -> Number
deltaY = _deltaY

deltaZ :: forall wheelEvent. WheelEvent wheelEvent => wheelEvent -> Number
deltaZ = _deltaZ

-- | The unit of the deltas: 0 for pixels, 1 for lines, 2 for pages. Firefox reports a mouse wheel in
-- | lines only if this is read before the deltas, and in pixels otherwise.
deltaMode :: forall wheelEvent. WheelEvent wheelEvent => wheelEvent -> Int
deltaMode = _deltaMode

wheel :: EventType WheelEvent
wheel = EventType "wheel"
