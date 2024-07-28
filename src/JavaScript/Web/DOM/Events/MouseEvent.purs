module JavaScript.DOM.Events.MouseEvent where

import JavaScript.DOM.Class.Event (class Event)
import JavaScript.DOM.Class.MouseEvent (class MouseEvent, altKeyDefault, buttonDefault, buttonsDefault, clientXDefault, clientYDefault, ctrlKeyDefault, metaKeyDefault, offsetXDefault, offsetYDefault, pageXDefault, pageYDefault, shiftKeyDefault)
import JavaScript.DOM.Class.UiEvent (class UiEvent, detailDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data MouseEvent :: Type

instance Event MouseEvent

instance uiEventMouseEvent :: UiEvent MouseEvent where
    detail = detailDefault

instance mouseEventMouseEvent :: MouseEvent MouseEvent where
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

mouseenter :: EventType MouseEvent
mouseenter = EventType "mouseenter"

mouseleave :: EventType MouseEvent
mouseleave = EventType "mouseleave"

mouseover :: EventType MouseEvent
mouseover = EventType "mouseover"

mouseout :: EventType MouseEvent
mouseout = EventType "mouseout"

mousemove :: EventType MouseEvent
mousemove = EventType "mousemove"

mousedown :: EventType MouseEvent
mousedown = EventType "mousedown"

mouseup :: EventType MouseEvent
mouseup = EventType "mouseup"

click :: EventType MouseEvent
click = EventType "click"
