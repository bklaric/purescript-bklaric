module JavaScript.Web.URL.URLSearchParams (URLSearchParams, new, new_, get, toString) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable)
import Data.Nullable as Nullable
import Effect (Effect)
import Foreign.Object (Object)
import Literals.Undefined (Undefined, undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Web/API/URLSearchParams

foreign import data URLSearchParams :: Type

foreign import _new :: String |+| Object String |+| Undefined -> Effect URLSearchParams

new :: forall params. Castable params (String |+| Object String |+| Undefined) => params -> Effect URLSearchParams
new params = _new $ cast params

new_ :: Effect URLSearchParams
new_ = _new $ cast undefined

foreign import _get :: String -> URLSearchParams -> Effect (Nullable String)

get :: String -> URLSearchParams -> Effect (Maybe String)
get key params = _get key params <#> Nullable.toMaybe

foreign import toString :: URLSearchParams -> Effect String
