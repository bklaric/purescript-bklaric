module JavaScript.Web.DOM.Class.FocusEvent where

import Data.Nullable (Nullable)
import JavaScript.Web.DOM.Class (class UiEvent)
import JavaScript.Web.DOM.EventTarget (EventTarget)

class UiEvent focusEvent <= FocusEvent focusEvent where
    relatedTarget :: focusEvent -> Nullable EventTarget

foreign import relatedTargetDefault :: forall focusEvent. focusEvent -> Nullable EventTarget
