module JavaScript.DOM.Class.EventTarget where

import Prelude

import Data.Options (Option, Options, opt, options)
import JavaScript.DOM.Class.Event (class Event)
import JavaScript.DOM.Element (Element)
import JavaScript.DOM.Events.EventType (EventType)
import Effect (Effect)
import Foreign (Foreign)

foreign import data EventListener :: Type -> Type

foreign import toEventListener :: forall event return. (event -> Effect return) -> Effect (EventListener event)

data EventOptions

capture :: Option EventOptions Boolean
capture = opt "capture"

once :: Option EventOptions Boolean
once = opt "once"

passive :: Option EventOptions Boolean
passive = opt "passive"

class EventTarget eventTarget where
    addEventListener :: forall event. Event event => EventType event -> EventListener event -> Options EventOptions -> eventTarget -> Effect Unit
    removeEventListener :: forall event. Event event => EventType event -> EventListener event -> eventTarget -> Effect Unit
    dispatchEvent :: forall event. Event event => event -> eventTarget -> Effect Unit

instance EventTarget Element where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

foreign import addEventListenerImpl :: forall event eventTarget. EventType event -> EventListener event -> Foreign -> eventTarget -> Effect Unit

foreign import removeEventListenerImpl :: forall event eventTarget. EventType event -> EventListener event -> eventTarget -> Effect Unit

foreign import dispatchEventImpl :: forall event eventTarget. event -> eventTarget -> Effect Unit

addEventListenerDefault :: forall eventTarget event. EventTarget eventTarget => Event event =>
    EventType event -> EventListener event -> Options EventOptions -> eventTarget -> Effect Unit
addEventListenerDefault type' listener opts target = addEventListenerImpl type' listener (options opts) target

removeEventListenerDefault :: forall eventTarget event. EventTarget eventTarget => Event event =>
    EventType event -> EventListener event -> eventTarget -> Effect Unit
removeEventListenerDefault = removeEventListenerImpl

dispatchEventDefault :: forall eventTarget event. EventTarget eventTarget => Event event =>
    event -> eventTarget -> Effect Unit
dispatchEventDefault = dispatchEventImpl

addEventListener_ :: forall eventTarget event. EventTarget eventTarget => Event event =>
    EventType event -> EventListener event -> eventTarget -> Effect Unit
addEventListener_ type' listener target = addEventListener type' listener mempty target

addEventListener_' :: forall return eventTarget event. EventTarget eventTarget => Event event =>
    EventType event -> (event -> Effect return) -> eventTarget -> Effect Unit
addEventListener_' type' listener target = do
    eventListener <- toEventListener listener
    addEventListener_ type' eventListener target

addEventListener' :: forall eventTarget event return. EventTarget eventTarget => Event event =>
    EventType event -> (event -> Effect return) -> Options EventOptions -> eventTarget -> Effect Unit
addEventListener' type' listener opts target = do
    eventListener <- toEventListener listener
    addEventListener type' eventListener opts target
