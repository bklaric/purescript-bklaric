module JavaScript.DOM.Events.EventTarget where

import JavaScript.DOM.Class.Event (class Event)
import JavaScript.DOM.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)

foreign import data EventTarget :: Type

instance EventTarget EventTarget where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

foreign import targetImpl :: forall event. event -> EventTarget

target :: forall event. Event event => event -> EventTarget
target = targetImpl
