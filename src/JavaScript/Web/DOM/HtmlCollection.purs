module JavaScript.DOM.HtmlCollection where

import JavaScript.DOM.Element (Element)
import JavaScript.DOM.Utils (class ToArray, toArrayDefault)

foreign import data HtmlCollection :: Type

instance ToArray HtmlCollection Element where
    toArray = toArrayDefault
