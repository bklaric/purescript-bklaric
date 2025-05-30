module JavaScript.Web.DOM.Events.FocusEvent where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import JavaScript.Web.DOM.Class (class Event, class FocusEvent, class UiEvent)
import JavaScript.Web.DOM.EventTarget (EventTarget)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data FocusEvent :: Type

instance Event FocusEvent
instance UiEvent FocusEvent
instance FocusEvent FocusEvent

foreign import _relatedTarget :: forall focusEvent. focusEvent -> Nullable EventTarget

relatedTarget :: forall focusEvent. FocusEvent focusEvent => focusEvent -> Maybe EventTarget
relatedTarget = _relatedTarget >>> toMaybe

focus :: EventType FocusEvent
focus = EventType "focus"

blur :: EventType FocusEvent
blur = EventType "blur"

focusin :: EventType FocusEvent
focusin = EventType "focusin"

focusout :: EventType FocusEvent
focusout = EventType "focusout"
