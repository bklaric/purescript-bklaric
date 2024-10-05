module JavaScript.Chrome.Shared.Event where

import Prelude

import Effect (Effect)

foreign import data Event :: Symbol -> Type -> Type

foreign import data EventListener :: Symbol -> Type -> Type

foreign import toEventListener :: forall source listener.
    listener -> EventListener source listener

foreign import addListener :: forall source listener. EventListener source listener -> Event source listener -> Effect Unit

addListener' :: forall source listener. listener -> Event source listener -> Effect Unit
addListener' listener event = event # addListener (toEventListener listener)

foreign import removeListener :: forall source listener. EventListener source listener -> Event source listener -> Effect Unit

foreign import hasListener :: forall source listener. EventListener source listener -> Event source listener -> Effect Unit
