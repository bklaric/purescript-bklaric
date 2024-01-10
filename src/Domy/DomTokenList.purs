module Domy.DomTokenList where

import Prelude

import Domy.Utils (class ToArray, toArrayDefault)
import Effect (Effect)

foreign import data DomTokenList :: Type

instance ToArray DomTokenList String where
    toArray = toArrayDefault

foreign import add :: String -> DomTokenList -> Effect Unit

foreign import remove :: String -> DomTokenList -> Effect Unit
