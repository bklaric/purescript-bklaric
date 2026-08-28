module JavaScript.Node.Timers
    ( Timeout
    , setInterval
    , clearInterval
    , ref
    , unref
    ) where

import Prelude

import Effect (Effect)

-- https://nodejs.org/api/timers.html#class-timeout
--
-- Node's timer handle, rather than the numeric id `Effect.Timer` models after the
-- browser. Only this one can be unref'd, which is what lets a repeating timer run
-- without keeping the process alive by itself.
foreign import data Timeout :: Type

foreign import setInterval :: Int -> Effect Unit -> Effect Timeout

foreign import clearInterval :: Timeout -> Effect Unit

-- Keep the event loop alive while this timer is pending. The default.
foreign import ref :: Timeout -> Effect Unit

-- Stop this timer from keeping the event loop alive on its own. The process may
-- exit with it still pending.
foreign import unref :: Timeout -> Effect Unit
