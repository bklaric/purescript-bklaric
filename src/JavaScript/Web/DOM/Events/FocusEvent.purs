module JavaScript.DOM.Events.FocusEvent where

import JavaScript.DOM.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import JavaScript.DOM.Class.FocusEvent (class FocusEvent, relatedTargetDefault)
import JavaScript.DOM.Class.UiEvent (class UiEvent, detailDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data FocusEvent :: Type

instance Event FocusEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

instance UiEvent FocusEvent where
    detail = detailDefault

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
