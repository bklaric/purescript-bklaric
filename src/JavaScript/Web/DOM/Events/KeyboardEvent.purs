module JavaScript.Web.DOM.Events.KeyboardEvent where

import JavaScript.Web.DOM.Class (class Event, class UiEvent, class KeyboardEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data KeyboardEvent :: Type

instance Event KeyboardEvent
instance UiEvent KeyboardEvent
instance KeyboardEvent KeyboardEvent

foreign import _key :: forall keyboardEvent. keyboardEvent -> String
foreign import _code :: forall keyboardEvent. keyboardEvent -> String
foreign import _altKey :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import _ctrlKey :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import _shiftKey :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import _metaKey :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import _getModifierState :: forall keyboardEvent. String -> keyboardEvent -> Boolean

key :: forall keyboardEvent. KeyboardEvent keyboardEvent => keyboardEvent -> String
key = _key

code :: forall keyboardEvent. KeyboardEvent keyboardEvent => keyboardEvent -> String
code = _code

altKey :: forall keyboardEvent. KeyboardEvent keyboardEvent => keyboardEvent -> Boolean
altKey = _altKey

ctrlKey :: forall keyboardEvent. KeyboardEvent keyboardEvent => keyboardEvent -> Boolean
ctrlKey = _ctrlKey

shiftKey :: forall keyboardEvent. KeyboardEvent keyboardEvent => keyboardEvent -> Boolean
shiftKey = _shiftKey

metaKey :: forall keyboardEvent. KeyboardEvent keyboardEvent => keyboardEvent -> Boolean
metaKey = _metaKey

getModifierState :: forall keyboardEvent. KeyboardEvent keyboardEvent => String -> keyboardEvent -> Boolean
getModifierState = _getModifierState

keydown :: EventType KeyboardEvent
keydown = EventType "keydown"

keypress :: EventType KeyboardEvent
keypress = EventType "keypress"

keyup :: EventType KeyboardEvent
keyup = EventType "keyup"
