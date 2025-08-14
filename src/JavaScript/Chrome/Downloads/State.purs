module JavaScript.Chrome.Downloads.State where

import Literals (StringLit)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/downloads/State

type State = StringLit "in_progress" |+| StringLit "interrupted" |+| StringLit "complete"
