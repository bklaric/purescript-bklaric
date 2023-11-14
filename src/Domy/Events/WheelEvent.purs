module Domy.Events.WheelEvent where

import Domy.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import Domy.Class.MouseEvent (class MouseEvent, altKeyDefault, buttonDefault, buttonsDefault, clientXDefault, clientYDefault, ctrlKeyDefault, metaKeyDefault, offsetXDefault, offsetYDefault, pageXDefault, pageYDefault, shiftKeyDefault)
import Domy.Class.UiEvent (class UiEvent, detailDefault)
import Domy.Class.WheelEvent (class WheelEvent, deltaXDefault, deltaYDefault, deltaZDefault)
import Domy.Events.EventType (EventType(..))

foreign import data WheelEvent :: Type

instance eventWheelEvent :: Event WheelEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

instance uiEventWheelEvent :: UiEvent WheelEvent where
    detail = detailDefault

instance mouseEventWheelEvent :: MouseEvent WheelEvent where
    button = buttonDefault
    buttons = buttonsDefault
    pageX = pageXDefault
    pageY = pageYDefault
    offsetX = offsetXDefault
    offsetY = offsetYDefault
    clientX = clientXDefault
    clientY = clientYDefault
    altKey = altKeyDefault
    ctrlKey = ctrlKeyDefault
    shiftKey = shiftKeyDefault
    metaKey = metaKeyDefault

instance wheelEventWheelEvent :: WheelEvent WheelEvent where
    deltaX = deltaXDefault
    deltaY = deltaYDefault
    deltaZ = deltaZDefault

wheel :: EventType WheelEvent
wheel = EventType "wheel"
