module JavaScript.Chrome.Tabs.TabStatus where

import Literals (StringLit)
import Untagged.Union (type (|+|))

type TabStatus
    =   StringLit "loading"
    |+| StringLit "complete"
