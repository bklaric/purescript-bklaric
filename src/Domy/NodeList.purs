module Domy.NodeList where

import Domy.Node (Node)
import Domy.Utils (class ToArray, toArrayDefault)

foreign import data NodeList :: Type

instance ToArray NodeList Node where
    toArray = toArrayDefault
