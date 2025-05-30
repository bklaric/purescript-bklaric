module JavaScript.Web.DOM.Events.PopStateEvent where

import Foreign (Foreign)
import JavaScript.Web.DOM.Class (class Event, class PopStateEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data PopStateEvent :: Type

instance Event PopStateEvent
instance PopStateEvent PopStateEvent

foreign import _state :: forall popStateEvent. popStateEvent -> Foreign

state :: forall popStateEvent. PopStateEvent popStateEvent => popStateEvent -> Foreign
state = _state

popstate :: EventType PopStateEvent
popstate = EventType "popstate"
