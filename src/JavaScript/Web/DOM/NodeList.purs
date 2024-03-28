module JavaScript.DOM.NodeList where

import JavaScript.DOM.Node (Node)
import JavaScript.DOM.Utils (class ToArray, toArrayDefault)

foreign import data NodeList :: Type

instance ToArray NodeList Node where
    toArray = toArrayDefault
