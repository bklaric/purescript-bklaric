module Promisey where

import Prelude

import Data.Bifunctor (class Bifunctor, rmap)
import Data.Either (Either, either)
import Effect (Effect)
import Effect.Class (class MonadEffect)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|))

foreign import data Promise :: Type -> Type -> Type

instance Functor (Promise left) where
    map = rmap

instance Apply (Promise left) where
    apply = ap

instance Applicative (Promise left) where
    pure = resolve

instance Bind (Promise left) where
    bind = flip then_

instance Monad (Promise left)

instance MonadEffect (Promise left) where
    liftEffect = fromEffect

instance Bifunctor Promise where
    bimap = bimapImpl

foreign import fromEffect :: forall left right
    .  Effect right
    -> Promise left right

foreign import runPromise :: forall left right
    .  (left -> Effect Unit)
    -> (right -> Effect Unit)
    -> Promise left right
    -> Effect Unit

foreign import _new :: forall left right
    .  ((right |+| Promise left right -> Effect Unit) -> (left -> Effect Unit) -> Effect Unit)
    -> Promise left right

new :: forall left right right'. InOneOf right' right (Promise left right)
    => ((right' -> Effect Unit) -> (left -> Effect Unit) -> Effect Unit)
    -> Promise left right
new executor = _new \resolve' reject' -> executor (cast >>> resolve') reject'

foreign import then_ :: forall left right rightNext
    .  (right -> Promise left rightNext)
    -> Promise left right
    -> Promise left rightNext

foreign import catch :: forall left leftNext right
    .  (left -> Promise leftNext right)
    -> Promise left right
    -> Promise leftNext right

foreign import thenOrCatch :: forall left right leftNext rightNext
    .  (right -> Promise leftNext rightNext)
    -> (left -> Promise leftNext rightNext)
    -> Promise left right
    -> Promise leftNext rightNext

foreign import bimapImpl :: forall left right leftNext rightNext
    .  (left -> leftNext)
    -> (right -> rightNext)
    -> Promise left right
    -> Promise leftNext rightNext

foreign import finally :: forall left leftNext right
    .  Promise leftNext Unit
    -> Promise left right
    -> Promise leftNext right

foreign import resolve :: forall left right. right -> Promise left right

foreign import reject :: forall left right. left -> Promise left right

foreign import all :: forall left right. Array (Promise left right) -> Promise left (Array right)

foreign import race :: forall left right. Array (Promise left right) -> Promise left right

thenIgnore :: forall left right. (right -> Effect Unit) -> Promise left right -> Effect Unit
thenIgnore handler promise = promise # runPromise mempty (\value -> handler value)

ignore :: forall left right. Promise left right -> Effect Unit
ignore promise = promise # runPromise mempty mempty

fromEither :: forall left right. Either left right -> Promise left right
fromEither = either reject resolve

forkPromise :: forall left right
    .  (left -> Effect Unit)
    -> (right -> Effect Unit)
    -> Promise left right
    -> (forall voidLeft. Promise voidLeft Unit)
forkPromise resolved rejected promise = fromEffect $ runPromise resolved rejected promise
