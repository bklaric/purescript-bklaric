module JavaScript.DOM.Events.WheelEvent where

import JavaScript.DOM.Class.Event (class Event)
import JavaScript.DOM.Class.MouseEvent (class MouseEvent, altKeyDefault, buttonDefault, buttonsDefault, clientXDefault, clientYDefault, ctrlKeyDefault, metaKeyDefault, offsetXDefault, offsetYDefault, pageXDefault, pageYDefault, shiftKeyDefault)
import JavaScript.DOM.Class.UiEvent (class UiEvent, detailDefault)
import JavaScript.DOM.Class.WheelEvent (class WheelEvent, deltaXDefault, deltaYDefault, deltaZDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data WheelEvent :: Type

instance Event WheelEvent

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
