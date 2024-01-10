module Domy.Events.PopStateEvent where

import Domy.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import Domy.Class.PopStateEvent (class PopStateEvent, stateDefault)
import Domy.Events.EventType (EventType(..))

foreign import data PopStateEvent :: Type

instance eventMouseEvent :: Event PopStateEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

instance mouseEventMouseEvent :: PopStateEvent PopStateEvent where
    state = stateDefault

popstate :: EventType PopStateEvent
popstate = EventType "popstate"
