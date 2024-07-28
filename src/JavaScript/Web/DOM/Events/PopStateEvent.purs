module JavaScript.Web.DOM.Events.PopStateEvent where

import JavaScript.Web.DOM.Class.Event (class Event)
import JavaScript.Web.DOM.Class.PopStateEvent (class PopStateEvent, stateDefault)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data PopStateEvent :: Type

instance Event PopStateEvent

instance PopStateEvent PopStateEvent where
    state = stateDefault

popstate :: EventType PopStateEvent
popstate = EventType "popstate"
