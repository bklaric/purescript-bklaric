module Effect.Console.Unsafe (unsafeLog, unsafeLog') where

import Prelude

import Effect (Effect)
import Effect.Class (class MonadEffect, liftEffect)
import Unsafe.Coerce (unsafeCoerce)

-- The args are expected to be an array.
foreign import _log :: forall args. args -> Effect Unit

unsafeLog :: forall anything effect. MonadEffect effect => anything -> effect Unit
unsafeLog arg = _log [arg] # liftEffect

unsafeLog' :: forall anything effect. MonadEffect effect => String -> anything -> effect Unit
unsafeLog' label arg = _log [unsafeCoerce label, arg] # liftEffect
