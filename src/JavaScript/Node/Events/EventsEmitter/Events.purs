module JavaScript.Node.Events.EventEmitter.Events where

import Prelude

import Foreign (Foreign)
import Effect (Effect)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Events.EventListener (EventListener)

newListener :: forall emitter. EventEmitter emitter =>
    Event emitter
        (Event emitter Foreign -> EventListener Foreign -> Effect Unit)
newListener = Event "newListener"

removeListener :: forall emitter. EventEmitter emitter =>
    Event emitter
        (Event emitter Foreign -> EventListener Foreign -> Effect Unit)
removeListener = Event "removeListener"
