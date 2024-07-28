module JavaScript.Web.DOM.HtmlCollection where

import JavaScript.Web.DOM.Element (Element)
import JavaScript.Web.DOM.Utils (class ToArray, toArrayDefault)

foreign import data HtmlCollection :: Type

instance ToArray HtmlCollection Element where
    toArray = toArrayDefault
