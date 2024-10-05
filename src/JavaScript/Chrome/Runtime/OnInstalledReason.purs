module JavaScript.Chrome.Runtime.OnInstalledReason where

import Literals (StringLit)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/runtime/OnInstalledReason

type OnInstalledReason = StringLit "install" |+| StringLit "update" |+| StringLit "chrome_update" |+| StringLit "shared_module_update"
