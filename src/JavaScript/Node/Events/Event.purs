module JavaScript.Node.Events.Event where

newtype Event :: forall k1 k2. k1 -> k2 -> Type
newtype Event emitter listener = Event String
