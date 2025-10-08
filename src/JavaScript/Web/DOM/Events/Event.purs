module JavaScript.Web.DOM.Events.Event (Event, preventDefault, stopPropagation, stopImmediatePropagation, target, isTrusted, resize, scroll, load, change, domcontentloaded) where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.Class (class Event)
import JavaScript.Web.DOM.EventTarget (EventTarget)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data Event :: Type

instance Event Event

foreign import _preventDefault :: forall event. event -> Effect Unit
foreign import _stopPropagation :: forall event. event -> Effect Unit
foreign import _stopImmediatePropagation :: forall event. event -> Effect Unit
foreign import _target :: forall event. event -> EventTarget
foreign import _isTrusted :: forall event. event -> Boolean

preventDefault :: forall event. Event event => event -> Effect Unit
preventDefault = _preventDefault

stopPropagation :: forall event. Event event => event -> Effect Unit
stopPropagation = _stopPropagation

stopImmediatePropagation :: forall event. Event event => event -> Effect Unit
stopImmediatePropagation = _stopImmediatePropagation

target :: forall event. Event event => event -> EventTarget
target = _target

isTrusted :: forall event. Event event => event -> Boolean
isTrusted = _isTrusted

resize :: EventType Event
resize = EventType "resize"

scroll :: EventType Event
scroll = EventType "scroll"

load :: EventType Event
load = EventType "load"

change :: EventType Event
change = EventType "change"

domcontentloaded :: EventType Event
domcontentloaded = EventType "DOMContentLoaded"
