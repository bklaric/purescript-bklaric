module JavaScript.DOM.Events.UiEvent where

import JavaScript.DOM.Class.Event (class Event)

foreign import data MouseEvent :: Type

instance Event MouseEvent
