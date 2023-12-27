module Promisey where

import Prelude

import Effect (Effect)

foreign import data Promise :: Type -> Type -> Type

foreign import new :: forall left right
    .  ((right -> Effect Unit) -> (left -> Effect Unit) -> Effect Unit)
    -> Effect (Promise left right)

foreign import then_ :: forall left right rightNext
    .  (right -> Effect (Promise left rightNext))
    -> Promise left right
    -> Effect (Promise left rightNext)

foreign import catch :: forall left leftNext right
    . (left -> Effect (Promise leftNext right))
    -> Promise left right
    -> Effect (Promise leftNext right)

foreign import thenOrCatch :: forall left right leftNext rightNext
    .  (right -> Effect (Promise leftNext rightNext))
    -> (left -> Effect (Promise leftNext rightNext))
    -> Promise left right
    -> Effect (Promise leftNext rightNext)

foreign import finally :: forall left leftNext right
    .  (Effect (Promise leftNext Unit))
    -> Promise left right
    -> Effect (Promise leftNext right)

foreign import resolve :: forall left right. right -> Effect (Promise left right)

foreign import reject :: forall left right. left -> Effect (Promise left right)

foreign import all :: forall left right. Array (Promise left right) -> Effect (Promise left (Array right))

foreign import race :: forall left right. Array (Promise left right) -> Effect (Promise left right)

ignore :: forall left right. Promise left right -> Effect Unit
ignore promise = promise # thenOrCatch (const $ resolve unit) (const $ resolve unit) # void
