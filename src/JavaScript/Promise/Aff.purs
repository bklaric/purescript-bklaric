module JavaScript.Promise.Aff (promiseToAff) where

import Prelude

import Data.Either (Either(..))
import Effect.Aff (Aff, Error, makeAff)
import JavaScript.Promise (Promise, runPromise)

-- | Halogen runs its components in `Aff`, so a component written in `Promise`
-- | is hoisted through this. The canceler does nothing: a promise can't be
-- | cancelled, only its work aborted through the signal it was given.
promiseToAff :: ∀ left right. (left -> Error) -> Promise left right -> Aff right
promiseToAff toError promise = makeAff \callback ->
    promise
    # runPromise (toError >>> Left >>> callback) (Right >>> callback)
    <#> mempty
