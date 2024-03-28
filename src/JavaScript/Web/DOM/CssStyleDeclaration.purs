module JavaScript.DOM.CssStyleDeclaration where

import Effect (Effect)
import Prelude (Unit)

foreign import data CssStyleDeclaration :: Type

foreign import setProperty :: String -> String -> CssStyleDeclaration -> Effect Unit
