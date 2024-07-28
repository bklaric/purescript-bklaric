module JavaScript.Web.DOM.Class.HtmlElement where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.CssStyleDeclaration (CssStyleDeclaration)

class Element htmlElement <= HtmlElement htmlElement where
    offsetWidth :: htmlElement -> Effect Int
    offsetHeight :: htmlElement -> Effect Int
    style :: htmlElement -> Effect CssStyleDeclaration
    setStyle :: String -> htmlElement -> Effect Unit

foreign import offsetWidthDefault :: forall htmlElement. htmlElement -> Effect Int
foreign import offsetHeightDefault :: forall htmlElement. htmlElement -> Effect Int

foreign import styleDefault :: forall htmlElement. htmlElement -> Effect CssStyleDeclaration
foreign import setStyleDefault :: forall htmlElement. String -> htmlElement -> Effect Unit
