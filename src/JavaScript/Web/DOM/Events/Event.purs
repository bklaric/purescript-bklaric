module JavaScript.Web.DOM.Events.Event where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.Class (class Event)
import JavaScript.Web.DOM.Events.EventType (EventType(..))
import JavaScript.Web.DOM.EventTarget (EventTarget)

foreign import data Event :: Type

instance Event Event

foreign import _preventDefault :: forall event. event -> Effect Unit
foreign import _stopPropagation :: forall event. event -> Effect Unit
foreign import _stopImmediatePropagation :: forall event. event -> Effect Unit
foreign import _target :: forall event. event -> EventTarget

preventDefault :: forall event. Event event => event -> Effect Unit
preventDefault = _preventDefault

stopPropagation :: forall event. Event event => event -> Effect Unit
stopPropagation = _stopPropagation

stopImmediatePropagation :: forall event. Event event => event -> Effect Unit
stopImmediatePropagation = _stopImmediatePropagation

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
