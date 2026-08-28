module JavaScript.Node.Process
    ( lookupEnv
    , env
    , exit
    , onSignal
    , onUncaughtException
    , onUnhandledRejection
    ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign (Foreign)
import Foreign.Object (Object)
import JavaScript.Error (Error)

foreign import lookupEnvImpl :: String -> Effect (Nullable String)

lookupEnv :: String -> Effect (Maybe String)
lookupEnv variableName = lookupEnvImpl variableName <#> toMaybe

foreign import env :: Effect (Object String)

-- Terminate the process with the given exit code (0 = success).
foreign import exit :: Int -> Effect Unit

foreign import onSignalImpl :: String -> Effect Unit -> Effect Unit

-- | Run the handler when the process receives the named signal ("SIGTERM",
-- | "SIGINT", ...). Registering one replaces the runtime's default behavior for
-- | that signal, so the handler owns whether and when the process exits -- which
-- | is what makes a cooperative drain possible.
onSignal :: String -> Effect Unit -> Effect Unit
onSignal = onSignalImpl

-- | Handle an exception that reached the top of the stack. Registering this
-- | keeps the process alive past an uncaught throw, so it is only safe where the
-- | process can carry on meaningfully.
foreign import onUncaughtException :: (Error -> Effect Unit) -> Effect Unit

-- | Handle a rejected promise nobody caught. The reason is whatever was thrown,
-- | which need not be an Error -- use `JavaScript.Error.readError` to find out.
foreign import onUnhandledRejection :: (Foreign -> Effect Unit) -> Effect Unit
