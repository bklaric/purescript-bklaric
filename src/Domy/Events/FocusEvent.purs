module Domy.Events.FocusEvent where

import Domy.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import Domy.Class.FocusEvent (class FocusEvent, relatedTargetDefault)
import Domy.Class.UiEvent (class UiEvent, detailDefault)
import Domy.Events.EventType (EventType(..))

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
