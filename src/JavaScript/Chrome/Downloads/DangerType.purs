module JavaScript.Chrome.Downloads.DangerType where

import Literals (StringLit)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/downloads/DangerType

type DangerType
    =   StringLit "file"
    |+| StringLit "url"
    |+| StringLit "content"
    |+| StringLit "uncommon"
    |+| StringLit "host"
    |+| StringLit "unwanted"
    |+| StringLit "safe"
    |+| StringLit "accepted"
