module JavaScript.Web.Fetch.Headers (Headers, get, new, set) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign.Object (Object)
import Literals.Undefined (Undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Web/API/Headers

foreign import data Headers :: Type

type HeadersInit = Undefined |+| Headers |+| Object String

-- Effect: each call makes a new, mutable object.
-- https://developer.mozilla.org/en-US/docs/Web/API/Headers/Headers
foreign import _new :: HeadersInit -> Effect Headers

new :: ∀ init. Castable init HeadersInit => init -> Effect Headers
new init = _new (cast init)

-- https://developer.mozilla.org/en-US/docs/Web/API/Headers/set
foreign import set :: String -> String -> Headers -> Effect Unit

-- Effect: `set` changes what a later `get` reads.
-- https://developer.mozilla.org/en-US/docs/Web/API/Headers/get
foreign import _get :: String -> Headers -> Effect (Nullable String)

get :: String -> Headers -> Effect (Maybe String)
get name headers = _get name headers <#> toMaybe
