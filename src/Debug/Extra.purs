module Debug.Extra where

import Prelude

import Effect.Console.Unsafe (unsafeLog)
import Effect.Unsafe (unsafePerformEffect)

spy_ :: ∀ a. a -> a
spy_ a = unsafePerformEffect (unsafeLog a $> a)
