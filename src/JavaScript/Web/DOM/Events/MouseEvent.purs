module JavaScript.Web.DOM.Events.MouseEvent  where

import JavaScript.Web.DOM.Class (class Event, class MouseEvent, class UiEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data MouseEvent :: Type

instance Event MouseEvent
instance UiEvent MouseEvent
instance MouseEvent MouseEvent

foreign import _button :: forall mouseEvent. mouseEvent -> Int
foreign import _buttons :: forall mouseEvent. mouseEvent -> Int
foreign import _pageX :: forall mouseEvent. mouseEvent -> Int
foreign import _pageY :: forall mouseEvent. mouseEvent -> Int
foreign import _offsetX :: forall mouseEvent. mouseEvent -> Int
foreign import _offsetY :: forall mouseEvent. mouseEvent -> Int
foreign import _clientX :: forall mouseEvent. mouseEvent -> Int
foreign import _clientY :: forall mouseEvent. mouseEvent -> Int
foreign import _altKey :: forall mouseEvent. mouseEvent -> Boolean
foreign import _ctrlKey :: forall mouseEvent. mouseEvent -> Boolean
foreign import _shiftKey :: forall mouseEvent. mouseEvent -> Boolean
foreign import _metaKey :: forall mouseEvent. mouseEvent -> Boolean

button :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
button = _button

buttons :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
buttons = _buttons

pageX :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
pageX = _pageX

pageY :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
pageY = _pageY

offsetX :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
offsetX = _offsetX

offsetY :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
offsetY = _offsetY

clientX :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
clientX = _clientX

clientY :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Int
clientY = _clientY

altKey :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Boolean
altKey = _altKey

ctrlKey :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Boolean
ctrlKey = _ctrlKey

shiftKey :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Boolean
shiftKey = _shiftKey

metaKey :: forall mouseEvent. MouseEvent mouseEvent => mouseEvent -> Boolean
metaKey = _metaKey

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
