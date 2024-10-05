module JavaScript.Web.DOM.Events.UiEvent (UiEvent, detail) where

import JavaScript.Web.DOM.Class (class Event, class UiEvent)

foreign import data UiEvent :: Type

instance Event UiEvent

foreign import _detail :: forall uiEvent. uiEvent -> Number

detail :: forall uiEvent. UiEvent uiEvent => uiEvent -> Number
detail = _detail
