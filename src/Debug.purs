module Debug where

import Prelude

import Effect.Console.Unsafe (unsafeLog)
import Effect.Unsafe (unsafePerformEffect)

pipeLog :: ∀ a. a -> a
pipeLog a = unsafePerformEffect (unsafeLog a $> a)
