module JavaScript.Web.DOM.Location where

import Prelude

import Effect (Effect)

foreign import data Location :: Type

foreign import protocol :: Location -> Effect String

foreign import hostname :: Location -> Effect String

foreign import port :: Location -> Effect String

foreign import host :: Location -> Effect String

foreign import origin :: Location -> Effect String

foreign import pathname :: Location -> Effect String

foreign import search :: Location -> Effect String

foreign import hash :: Location -> Effect String

foreign import href :: Location -> Effect String

foreign import setHref :: String -> Location -> Effect Unit
