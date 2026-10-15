module JavaScript.Web.DOM.Events.Event (Event, preventDefault, stopPropagation, stopImmediatePropagation, target, isTrusted, composedPath, resize, scroll, load, change, domcontentloaded, copy) where

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
foreign import _composedPath :: forall event. event -> Effect (Array EventTarget)

-- | The targets the event passes through, innermost first. Unlike `target`, the first entry is
-- | inside any open shadow root the event came from, not the host the event is retargeted to.
-- | Empty once the event has been dispatched.
composedPath :: forall event. Event event => event -> Effect (Array EventTarget)
composedPath = _composedPath

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

-- | Fired for the browser's Copy, however it was asked for: the shortcut on any keyboard layout,
-- | or a menu. Typed as a plain Event, as nothing here reads its `clipboardData`.
copy :: EventType Event
copy = EventType "copy"
