module JavaScript.DOM.Events.KeyboardEvent where

import JavaScript.DOM.Class.Event (class Event)
import JavaScript.DOM.Class.KeyboardEvent (class KeyboardEvent, altKeyDefault, codeDefault, ctrlKeyDefault, getModifierStateDefault, keyDefault, metaKeyDefault, shiftKeyDefault)
import JavaScript.DOM.Class.UiEvent (class UiEvent, detailDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data KeyboardEvent :: Type

instance Event KeyboardEvent

instance UiEvent KeyboardEvent where
    detail = detailDefault

instance KeyboardEvent KeyboardEvent where
    key = keyDefault
    code = codeDefault
    altKey = altKeyDefault
    ctrlKey = ctrlKeyDefault
    shiftKey = shiftKeyDefault
    metaKey = metaKeyDefault
    getModifierState = getModifierStateDefault

keydown :: EventType KeyboardEvent
keydown = EventType "keydown"

keypress :: EventType KeyboardEvent
keypress = EventType "keypress"

keyup :: EventType KeyboardEvent
keyup = EventType "keyup"
