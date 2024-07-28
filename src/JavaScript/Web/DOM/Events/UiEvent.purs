module JavaScript.Web.DOM.Events.UiEvent where

import JavaScript.Web.DOM.Class.Event (class Event)

foreign import data MouseEvent :: Type

instance Event MouseEvent
