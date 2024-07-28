module JavaScript.Web.DOM.Class.GetElementsByClassName where

import Prelude

import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Document (Document)
import JavaScript.Web.DOM.ElementType (Element)
import JavaScript.Web.DOM.HtmlCollection (HtmlCollection)
import JavaScript.Web.DOM.Utils (toArray)
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
