module JavaScript.DOM.Events.PopStateEvent where

import JavaScript.DOM.Class.Event (class Event)
import JavaScript.DOM.Class.PopStateEvent (class PopStateEvent, stateDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data PopStateEvent :: Type

instance Event PopStateEvent

instance mouseEventMouseEvent :: PopStateEvent PopStateEvent where
    state = stateDefault

popstate :: EventType PopStateEvent
popstate = EventType "popstate"
