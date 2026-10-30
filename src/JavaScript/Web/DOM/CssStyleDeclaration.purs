module JavaScript.Web.DOM.CssStyleDeclaration where

import Effect (Effect)
import Prelude (Unit)

foreign import data CssStyleDeclaration :: Type

foreign import getPropertyValue :: String -> CssStyleDeclaration -> Effect String

foreign import getPropertyPriority :: String -> CssStyleDeclaration -> Effect String

-- | Property, value and priority: "important" or "". An empty value removes the property.
foreign import setProperty :: String -> String -> String -> CssStyleDeclaration -> Effect Unit

foreign import setProperty_ :: String -> String -> CssStyleDeclaration -> Effect Unit

foreign import removeProperty :: String -> CssStyleDeclaration -> Effect Unit

foreign import cssText :: CssStyleDeclaration -> Effect String
