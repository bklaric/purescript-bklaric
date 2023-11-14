module Domy.Class.GetElementsByClassName where

import Prelude

import Domy.Class.Element (class Element)
import Domy.Document (Document)
import Domy.Element (Element)
import Domy.HtmlCollection (HtmlCollection)
import Domy.Utils (toArray)
import Effect (Effect)

class GetElementsByClassName element where
    getElementsByClassName :: String -> element -> Effect HtmlCollection

instance GetElementsByClassName Document where
    getElementsByClassName = getElementsByClassNameDefault

else instance (Element element) => GetElementsByClassName element where
    getElementsByClassName = getElementsByClassNameDefault

foreign import getElementsByClassNameDefault :: forall element. String -> element -> Effect HtmlCollection

getElementsByClassName' :: forall element. GetElementsByClassName element => String -> element -> Effect (Array Element)
getElementsByClassName' class_ element = getElementsByClassName class_ element >>= toArray
