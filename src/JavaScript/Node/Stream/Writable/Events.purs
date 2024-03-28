module JavaScript.Node.Stream.Writable.Events where

import Prelude

import Effect (Effect)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Node.Stream.Readable (class Readable)
import JavaScript.Node.Stream.Writable (class Writable)

close :: forall writable. Writable writable => Event writable (Effect Unit)
close = Event "close"

drain :: forall writable. Writable writable => Event writable (Effect Unit)
drain = Event "drain"

finish :: forall writable. Writable writable => Event writable (Effect Unit)
finish = Event "finish"

pipe :: forall writable readable. Writable writable => Readable readable =>
    Event writable (readable -> Effect Unit)
pipe = Event "pipe"

unpipe :: forall writable readable. Writable writable => Readable readable =>
    Event writable (readable -> Effect Unit)
unpipe = Event "unpipe"
