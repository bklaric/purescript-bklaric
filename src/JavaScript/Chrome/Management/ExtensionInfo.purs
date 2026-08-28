module JavaScript.Chrome.Management.ExtensionInfo where

import Prelude

import JavaScript.Chrome.Management.ExtensionInstallType (ExtensionInstallType, fromString)
import Data.Maybe (fromJust)
import Effect (Effect)
import Partial.Unsafe (unsafePartial)

foreign import data ExtensionInfo :: Type

foreign import _installType :: ExtensionInfo -> Effect String

installType :: ExtensionInfo -> Effect ExtensionInstallType
installType info = _installType info <#> (fromString >>> unsafePartial fromJust)
