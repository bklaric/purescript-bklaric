module Effect.Console.Unsafe where

import Prelude

import Effect.Class (class MonadEffect)
import Effect.Class.Console (log)
import Unsafe.Coerce (unsafeCoerce)

unsafeLog :: forall anything effect. MonadEffect effect => anything -> effect Unit
unsafeLog = log <<< unsafeCoerce
