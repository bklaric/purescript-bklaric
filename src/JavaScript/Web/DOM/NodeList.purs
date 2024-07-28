module JavaScript.Web.DOM.NodeList where

import JavaScript.Web.DOM.Node (Node)
import JavaScript.Web.DOM.Utils (class ToArray, toArrayDefault)

foreign import data NodeList :: Type

instance ToArray NodeList Node where
    toArray = toArrayDefault
