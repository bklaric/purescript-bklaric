module JavaScript.Chrome.I18n where

import Effect (Effect)
import Literals.Undefined (undefined)
import Untagged.Castable (cast)
import Untagged.Union (UndefinedOr)

foreign import _getMessage :: String -> UndefinedOr (Array String) -> UndefinedOr {escapeLt :: UndefinedOr Boolean} -> Effect String

getMessage :: String -> (Array String) -> {escapeLt :: UndefinedOr Boolean} -> Effect String
getMessage name substitutions options = _getMessage name (cast substitutions) (cast options)

getMessage_ :: String -> (Array String) -> Effect String
getMessage_ name substitutions = _getMessage name (cast substitutions) (cast undefined)

getMessage__ :: String -> Effect String
getMessage__ name = _getMessage name (cast undefined) (cast undefined)
