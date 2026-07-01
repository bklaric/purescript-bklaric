module JavaScript.Node.Process (lookupEnv, env, exit) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign.Object (Object)

foreign import lookupEnvImpl :: String -> Effect (Nullable String)

lookupEnv :: String -> Effect (Maybe String)
lookupEnv variableName = lookupEnvImpl variableName <#> toMaybe

foreign import env :: Effect (Object String)

-- Terminate the process with the given exit code (0 = success).
foreign import exit :: Int -> Effect Unit
