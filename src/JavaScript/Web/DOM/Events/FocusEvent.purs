module JavaScript.Web.DOM.Events.FocusEvent where

import JavaScript.Web.DOM.Class (class Event, class UiEvent)
import JavaScript.Web.DOM.Class.FocusEvent (class FocusEvent, relatedTargetDefault)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data FocusEvent :: Type

instance Event FocusEvent
instance UiEvent FocusEvent

instance FocusEvent FocusEvent where
    relatedTarget = relatedTargetDefault

focus :: EventType FocusEvent
focus = EventType "focus"

blur :: EventType FocusEvent
blur = EventType "blur"

focusin :: EventType FocusEvent
focusin = EventType "focusin"

focusout :: EventType FocusEvent
focusout = EventType "focusout"
