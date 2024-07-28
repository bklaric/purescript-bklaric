module JavaScript.Web.DOM.Events.Event where

import Prelude

import Effect (Effect)
import JavaScript.DOM.Class.Event (class Event)
import JavaScript.DOM.Events.EventType (EventType(..))
import JavaScript.Web.DOM.EventTarget (EventTarget)

foreign import data Event :: Type

instance Event Event

foreign import _preventDefault :: forall event. event -> Effect Unit
foreign import _stopPropagation :: forall event. event -> Effect Unit
foreign import _stopImmediatePropagation :: forall event. event -> Effect Unit
foreign import _target :: forall event. event -> EventTarget

preventDefaultDefault :: forall event. Event event => event -> Effect Unit
preventDefaultDefault = _preventDefault

stopPropagationDefault :: forall event. Event event => event -> Effect Unit
stopPropagationDefault = _stopPropagation

stopImmediatePropagationDefault :: forall event. Event event => event -> Effect Unit
stopImmediatePropagationDefault = _stopImmediatePropagation

target :: forall event. Event event => event -> EventTarget
target = _target

resize :: EventType Event
resize = EventType "resize"

load :: EventType Event
load = EventType "load"

change :: EventType Event
change = EventType "change"

domcontentloaded :: EventType Event
domcontentloaded = EventType "DOMContentLoaded"
