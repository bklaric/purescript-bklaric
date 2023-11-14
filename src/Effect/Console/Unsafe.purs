module Effect.Console.Unsafe where

import Prelude

import Effect (Effect)
import Effect.Console (log)
import Unsafe.Coerce (unsafeCoerce)

unsafeLog :: forall anything. anything -> Effect Unit
unsafeLog = log <<< unsafeCoerce
