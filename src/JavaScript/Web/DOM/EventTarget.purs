module JavaScript.Web.DOM.EventTarget where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.Class.Event (class Event)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Events.EventType (EventType)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

foreign import data EventTarget :: Type

instance EventTarget EventTarget

foreign import data EventListener :: Type -> Type

foreign import toEventListener :: forall event return. (event -> Effect return) -> Effect (EventListener event)

type EventOptions =
    { capture :: UndefinedOr Boolean
    , once :: UndefinedOr Boolean
    , passive :: UndefinedOr Boolean
    }

foreign import _addEventListener :: forall event eventTarget. EventType event -> EventListener event -> EventOptions -> eventTarget -> Effect Unit
foreign import _removeEventListener :: forall event eventTarget. EventType event -> EventListener event -> eventTarget -> Effect Unit
foreign import _dispatchEvent :: forall event eventTarget. event -> eventTarget -> Effect Unit

addEventListener :: forall eventTarget event options.
    Event event => Castable options EventOptions => EventTarget eventTarget =>
    EventType event -> EventListener event -> options -> eventTarget -> Effect Unit
addEventListener type' listener opts target = _addEventListener type' listener (cast opts) target

addEventListener_ :: forall eventTarget event.
    Event event => EventTarget eventTarget =>
    EventType event -> EventListener event -> eventTarget -> Effect Unit
addEventListener_ type' listener target = addEventListener type' listener {} target

addEventListener_' :: forall eventTarget event return.
    Event event => EventTarget eventTarget =>
    EventType event -> (event -> Effect return) -> eventTarget -> Effect Unit
addEventListener_' type' listener target = do
    eventListener <- toEventListener listener
    addEventListener_ type' eventListener target

addEventListener' :: forall eventTarget event options return.
    Event event => Castable options EventOptions => EventTarget eventTarget =>
    EventType event -> (event -> Effect return) -> options -> eventTarget -> Effect Unit
addEventListener' type' listener opts target = do
    eventListener <- toEventListener listener
    addEventListener type' eventListener opts target

removeEventListener :: forall eventTarget event.
    EventTarget eventTarget => Event event =>
    EventType event -> EventListener event -> eventTarget -> Effect Unit
removeEventListener = _removeEventListener

dispatchEvent :: forall eventTarget event.
    EventTarget eventTarget => Event event =>
    event -> eventTarget -> Effect Unit
dispatchEvent = _dispatchEvent
