module JavaScript.Chrome.Windows.WindowType where

import Literals (StringLit)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/windows/WindowType

type WindowType
    =   StringLit "normal"
    |+| StringLit "popup"
    |+| StringLit "panel"
    |+| StringLit "devtools"
