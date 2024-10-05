module JavaScript.Chrome.Management where

import Prelude

import JavaScript.Chrome.Management.ExtensionInfo (ExtensionInfo)
import Effect (Effect)

foreign import getSelf :: (ExtensionInfo -> Effect Unit) -> Effect Unit
