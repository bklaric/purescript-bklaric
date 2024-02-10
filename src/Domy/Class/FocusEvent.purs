module Domy.Class.FocusEvent where

import Data.Nullable (Nullable)
import Domy.Class.UiEvent (class UiEvent)
import Domy.Events.EventTarget (EventTarget)

class UiEvent focusEvent <= FocusEvent focusEvent where
    relatedTarget :: focusEvent -> Nullable EventTarget

foreign import relatedTargetDefault :: forall focusEvent. focusEvent -> Nullable EventTarget
