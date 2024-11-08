module JavaScript.Web.DOM.Events.PointerEvent where

import JavaScript.Web.DOM.Class (class Event, class MouseEvent, class UiEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data PointerEvent :: Type

instance Event PointerEvent
instance UiEvent PointerEvent
instance MouseEvent PointerEvent

pointerover :: EventType PointerEvent
pointerover = EventType "pointerover"

pointerenter :: EventType PointerEvent
pointerenter = EventType "pointerenter"

pointerdown :: EventType PointerEvent
pointerdown = EventType "pointerdown"

pointerup :: EventType PointerEvent
pointerup = EventType "pointerup"

contextmenu :: EventType PointerEvent
contextmenu = EventType "contextmenu"
