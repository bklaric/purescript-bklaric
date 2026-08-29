module JavaScript.Web.DOM.Events.KeyboardEvent where

import Prelude

import Data.Foldable (foldMap)
import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Event, class UiEvent, class KeyboardEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

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

-- | A `keydown`/`keyup` listener is not guaranteed a `KeyboardEvent`: Chrome's form
-- | autofill dispatches plain `Event`s of those types around a fill, so that sites
-- | which check for keyboard interaction accept the filled value. They carry no
-- | `key`, `code` or `getModifierState`, so a handler that binds a key reads the
-- | event through here and ignores anything that isn't a real keyboard event.
readKeyboardEvent :: forall object. object -> Maybe KeyboardEvent
readKeyboardEvent = unsafeReadProtoTagged "KeyboardEvent"

-- | Run `action` only when the event really is a `KeyboardEvent`.
whenKeyboardEvent :: forall object. object -> (KeyboardEvent -> Effect Unit) -> Effect Unit
whenKeyboardEvent object action = foldMap action (readKeyboardEvent object)

keydown :: EventType KeyboardEvent
keydown = EventType "keydown"

keypress :: EventType KeyboardEvent
keypress = EventType "keypress"

keyup :: EventType KeyboardEvent
keyup = EventType "keyup"
