module Domy.Events.KeyboardEvent where

import Domy.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import Domy.Class.KeyboardEvent (class KeyboardEvent, altKeyDefault, codeDefault, ctrlKeyDefault, keyDefault, metaKeyDefault, shiftKeyDefault)
import Domy.Class.UiEvent (class UiEvent, detailDefault)
import Domy.Events.EventType (EventType(..))

foreign import data KeyboardEvent :: Type

instance eventKeyboardEvent :: Event KeyboardEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

instance uiEventKeyboardEvent :: UiEvent KeyboardEvent where
    detail = detailDefault

instance mouseEventKeyboardEvent :: KeyboardEvent KeyboardEvent where
    key = keyDefault
    code = codeDefault
    altKey = altKeyDefault
    ctrlKey = ctrlKeyDefault
    shiftKey = shiftKeyDefault
    metaKey = metaKeyDefault

keydown :: EventType KeyboardEvent
keydown = EventType "keydown"

keypress :: EventType KeyboardEvent
keypress = EventType "keypress"

keyup :: EventType KeyboardEvent
keyup = EventType "keyup"
