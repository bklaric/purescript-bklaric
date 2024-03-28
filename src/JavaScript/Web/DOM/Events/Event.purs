module JavaScript.DOM.Events.Event where

import JavaScript.DOM.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data Event :: Type

instance eventEvent :: Event Event where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

resize :: EventType Event
resize = EventType "resize"

load :: EventType Event
load = EventType "load"

change :: EventType Event
change = EventType "change"

domcontentloaded :: EventType Event
domcontentloaded = EventType "DOMContentLoaded"
