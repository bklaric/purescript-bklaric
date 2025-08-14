module JavaScript.Chrome.Downloads.FilenameConflictAction where

import Literals (StringLit)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/downloads/FilenameConflictAction

type FilenameConflictAction
    =   StringLit "uniquify"
    |+| StringLit "overwrite"
    |+| StringLit "prompt"
