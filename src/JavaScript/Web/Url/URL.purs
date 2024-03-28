module JavaScript.Web.URL.URL (URL, new, new_, protocol, hostname, port, host, origin, pathname, search, hash, href, setHref) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import JavaScript.Error (Error)
import Literals.Undefined (Undefined, undefined)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|), OneOf)

foreign import data URL :: Type

foreign import newImpl
    :: (Error -> Either Error URL)
    -> (URL -> Either Error URL)
    -> (String |+| URL)
    -> (String |+| URL |+| Undefined)
    -> Effect (Either Error URL)

new
    :: forall url base
    .  InOneOf url String URL
    => InOneOf base String (OneOf URL Undefined)
    => url
    -> base
    -> Effect (Either Error URL)
new url base = newImpl Left Right (cast url) (cast base)

new_ :: forall url. InOneOf url String URL => url -> Effect (Either Error URL)
new_ url = new url undefined

foreign import protocol :: URL -> Effect String

foreign import hostname :: URL -> Effect String

foreign import port :: URL -> Effect String

foreign import host :: URL -> Effect String

foreign import origin :: URL -> Effect String

foreign import pathname :: URL -> Effect String

foreign import search :: URL -> Effect String

foreign import hash :: URL -> Effect String

foreign import href :: URL -> Effect String

foreign import setHref :: String -> URL -> Effect Unit
