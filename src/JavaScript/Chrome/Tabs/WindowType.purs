module JavaScript.Chrome.Tabs.WindowType where

import Literals (StringLit)
import Untagged.Union (type (|+|))

type WindowType
    =   StringLit "normal"
    |+| StringLit "popup"
    |+| StringLit "panel"
    |+| StringLit "devtools"
