module Node.Process (lookupEnv) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)

foreign import lookupEnvImpl :: String -> Effect (Nullable String)

lookupEnv :: String -> Effect (Maybe String)
lookupEnv variableName = lookupEnvImpl variableName <#> toMaybe
