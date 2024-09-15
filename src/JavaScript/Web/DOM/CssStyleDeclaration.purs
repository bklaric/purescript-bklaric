module JavaScript.Web.DOM.CssStyleDeclaration where

import Effect (Effect)
import Prelude (Unit)

foreign import data CssStyleDeclaration :: Type

foreign import getPropertyValue :: String -> CssStyleDeclaration -> Effect String

foreign import setProperty :: String -> String -> CssStyleDeclaration -> Effect Unit

foreign import removeProperty :: String -> CssStyleDeclaration -> Effect Unit
