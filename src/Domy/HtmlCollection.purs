module Domy.HtmlCollection where

import Domy.Element (Element)
import Domy.Utils (class ToArray, toArrayDefault)

foreign import data HtmlCollection :: Type

instance ToArray HtmlCollection Element where
    toArray = toArrayDefault
