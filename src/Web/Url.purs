module Web.Url (Url, new, protocol, hostname, port, host, origin, pathname, search, hash, href, setHref) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Error (Error)

foreign import data Url :: Type

foreign import newImpl :: (Error -> Either Error Url) -> (Url -> Either Error Url) -> String -> Effect (Either Error Url)

new :: String -> Effect (Either Error Url)
new = newImpl Left Right

foreign import protocol :: Url -> Effect String

foreign import hostname :: Url -> Effect String

foreign import port :: Url -> Effect String

foreign import host :: Url -> Effect String

foreign import origin :: Url -> Effect String

foreign import pathname :: Url -> Effect String

foreign import search :: Url -> Effect String

foreign import hash :: Url -> Effect String

foreign import href :: Url -> Effect String

foreign import setHref :: String -> Url -> Effect Unit
