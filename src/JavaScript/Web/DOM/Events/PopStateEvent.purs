module JavaScript.DOM.Events.PopStateEvent where

import JavaScript.DOM.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import JavaScript.DOM.Class.PopStateEvent (class PopStateEvent, stateDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data PopStateEvent :: Type

instance eventMouseEvent :: Event PopStateEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

instance mouseEventMouseEvent :: PopStateEvent PopStateEvent where
    state = stateDefault

popstate :: EventType PopStateEvent
popstate = EventType "popstate"
