module JavaScript.Npm.UAParserJs where

import Data.Nullable (Nullable)
import Effect (Effect)

type Result =
    { ua :: String
    , browser ::
        { name :: Nullable String
        , version :: Nullable String
        , major :: Nullable String
        , type :: Nullable String
        }
    , cpu ::
        { architecture :: Nullable String }
    , device ::
        { type :: Nullable String
        , vendor :: Nullable String
        , model :: Nullable String
        }
    , engine ::
        { name :: Nullable String
        , version :: Nullable String
        }
    , os ::
        { name :: Nullable String
        , version :: Nullable String
        }
    }

foreign import new :: Effect Result

-- Parse a user agent string that arrived from somewhere other than this runtime
-- -- a stored column, a request header. Pure, unlike `new`: that one is effectful
-- because it reads navigator.userAgent, whereas this is a function of its
-- argument, so callers can cache results in an ordinary Map.
foreign import parse :: String -> Result
