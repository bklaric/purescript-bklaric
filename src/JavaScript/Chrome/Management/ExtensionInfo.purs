module JavaScript.Chrome.Management.ExtensionInfo where

import Prelude

import JavaScript.Chrome.Management.ExtensionInstallType (ExtensionInstallType, fromString)
import Data.Maybe (fromJust)
import Effect (Effect)
import Partial.Unsafe (unsafePartial)

foreign import data ExtensionInfo :: Type

foreign import installTypeImpl :: ExtensionInfo -> Effect String

installType :: ExtensionInfo -> Effect ExtensionInstallType
installType info = installTypeImpl info <#> (fromString >>> unsafePartial fromJust)
