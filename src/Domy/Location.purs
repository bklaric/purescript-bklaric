module Domy.Location where

import Prelude

import Effect (Effect)

foreign import data Location :: Type

foreign import href :: Location -> Effect String

foreign import setHref :: String -> Location -> Effect Unit
