module JavaScript.Promise where

import Prelude

import Control.Apply (lift2)
import Control.Monad.Except (ExceptT, runExceptT)
import Data.Bifunctor (class Bifunctor, rmap)
import Data.Either (Either(..), either)
import Data.Either as Either
import Data.Maybe (Maybe, maybe)
import Data.Traversable (class Traversable, traverse)
import Effect (Effect)
import Effect.Class (class MonadEffect)
import Effect.Exception (throw, throwException)
import JavaScript.Error (readError)
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|))
import Yoga.JSON (unsafeStringify)

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

instance Semigroup right => Semigroup (Promise left right) where
    append = lift2 append

instance Monoid right => Monoid (Promise left right) where
    mempty = pure mempty

foreign import fromEffect :: forall right
    .  Effect right
    -> (forall voidLeft. Promise voidLeft right)

-- Treat the Promise like an Effect and let it go unhandled if rejected.
unsafeToEffect :: forall left right. Promise left right -> Effect Unit
unsafeToEffect = unsafeCoerce

foreign import runPromise :: forall left right
    .  (left -> Effect Unit)
    -> (right -> Effect Unit)
    -> Promise left right
    -> Effect Unit

-- If the promise actually ends up being rejected, rethrow the error so the promise goes unhandled.
runSafePromise :: ∀ right. (right -> Effect Unit) -> (∀ left. Promise left right) -> Effect Unit
runSafePromise = runPromise (\left -> left # readError # maybe (unsafeStringify left # throw) (unsafeCoerce >>> throwException))

runEmptyPromise :: (forall left. Promise left Unit) -> Effect Unit
runEmptyPromise = runSafePromise pure

runPromiseEither :: forall left right. (Either left right -> Effect Unit) -> Promise left right -> Effect Unit
runPromiseEither handler promise = promise # runPromise
    (\error -> handler $ Left error)
    (\result -> handler $ Right result)

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

thenEffect :: forall left right rightNext
    .  (right -> Effect rightNext)
    -> Promise left right
    -> Promise left rightNext
thenEffect handler promise = promise # then_ (handler >>> fromEffect)

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

disolve :: Promise Unit Unit -> Effect Unit
disolve = ignore

fromEither :: forall left right. Either left right -> Promise left right
fromEither = either reject resolve

fromEitherEffect :: ∀ left right.
    Effect (Either left right) -> Promise left right
fromEitherEffect eitherEffect = new \resolve' reject' -> eitherEffect >>= case _ of
    Left error -> reject' error
    Right result -> resolve' result

fromMaybe :: forall left right. left -> Maybe right -> Promise left right
fromMaybe left' maybe' = maybe' # Either.note left' # fromEither

fromMaybeEffect :: forall left right. left -> Effect (Maybe right) -> Promise left right
fromMaybeEffect left' maybeEffect = maybeEffect <#> Either.note left' # fromEitherEffect

fromExceptT :: forall left right. ExceptT left Effect right -> Promise left right
fromExceptT = runExceptT >>> fromEitherEffect

forkPromise :: forall left right
    .  (left -> Effect Unit)
    -> (right -> Effect Unit)
    -> Promise left right
    -> (forall voidLeft. Promise voidLeft Unit)
forkPromise resolved rejected promise = fromEffect $ runPromise resolved rejected promise

foreach :: ∀ left right traversable. Traversable traversable =>
    traversable right -> (right -> Promise left Unit) -> Promise left Unit
foreach traversable function = void $ traverse function traversable

safeForeach :: ∀ right traversable. Traversable traversable =>
    traversable right -> (∀ left. right -> Promise left Unit) -> (∀ left. Promise left Unit)
safeForeach traversable function = void $ traverse function traversable

alwaysRight :: forall inLeft inRight outRight
    .  (inLeft -> outRight)
    -> (inRight -> outRight)
    -> Promise inLeft inRight
    -> (forall voidLeft. Promise voidLeft outRight)
alwaysRight leftFunction rightFunction promise =
    promise # thenOrCatch (rightFunction >>> pure) (leftFunction >>> pure)

alwaysRightWithPromise
    :: ∀ inLeft inRight outRight
    .  (inLeft -> ∀ voidLeft. (Promise voidLeft outRight))
    -> (inRight -> ∀ voidLeft. (Promise voidLeft outRight))
    -> Promise inLeft inRight
    -> (∀ voidLeft. Promise voidLeft outRight)
alwaysRightWithPromise leftFunction rightFunction promise =
    promise # thenOrCatch rightFunction leftFunction

alwaysRightWithEffect
    :: ∀ inLeft inRight outRight
    .  (inLeft -> Effect outRight)
    -> (inRight -> Effect outRight)
    -> Promise inLeft inRight
    -> (∀ voidLeft. Promise voidLeft outRight)
alwaysRightWithEffect leftFunction rightFunction promise =
    promise # thenOrCatch (rightFunction >>> fromEffect) (leftFunction >>> fromEffect)

unify :: ∀ right. Promise right right -> (∀ left. Promise left right)
unify = alwaysRight identity identity

note :: ∀ right left. left -> Maybe right -> Promise left right
note left' maybe = maybe # Either.note left' # fromEither
