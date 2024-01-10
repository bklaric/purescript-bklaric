module Domy.Events.MouseEvent where

import Domy.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import Domy.Class.MouseEvent (class MouseEvent, altKeyDefault, buttonDefault, buttonsDefault, clientXDefault, clientYDefault, ctrlKeyDefault, metaKeyDefault, offsetXDefault, offsetYDefault, pageXDefault, pageYDefault, shiftKeyDefault)
import Domy.Class.UiEvent (class UiEvent, detailDefault)
import Domy.Events.EventType (EventType(..))

foreign import data MouseEvent :: Type

instance eventMouseEvent :: Event MouseEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

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
