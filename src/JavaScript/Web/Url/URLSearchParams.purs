module JavaScript.Web.URL.URLSearchParams (URLSearchParams, empty, fromString, fromObject, get) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable)
import Data.Nullable as Nullable
import Effect (Effect)
import Foreign.Object (Object)

foreign import data URLSearchParams :: Type

foreign import empty :: Effect URLSearchParams

foreign import fromString :: String -> Effect URLSearchParams

foreign import fromObject :: Object String -> Effect URLSearchParams

foreign import getImpl :: String -> URLSearchParams -> Effect (Nullable String)

get :: String -> URLSearchParams -> Effect (Maybe String)
get key params = getImpl key params <#> Nullable.toMaybe
