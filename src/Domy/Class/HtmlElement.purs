module Domy.Class.HtmlElement where

import Domy.Class.Element (class Element)
import Domy.CssStyleDeclaration (CssStyleDeclaration)
import Effect (Effect)

class Element htmlElement <= HtmlElement htmlElement where
    offsetWidth :: htmlElement -> Effect Int
    offsetHeight :: htmlElement -> Effect Int
    style :: htmlElement -> Effect CssStyleDeclaration

foreign import offsetWidthDefault :: forall htmlElement. htmlElement -> Effect Int
foreign import offsetHeightDefault :: forall htmlElement. htmlElement -> Effect Int

foreign import styleDefault :: forall htmlElement. htmlElement -> Effect CssStyleDeclaration
