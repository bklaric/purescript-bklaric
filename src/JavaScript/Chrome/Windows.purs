module JavaScript.Chrome.Windows where

import Prelude

import JavaScript.Chrome.Windows.Window (Window)
import JavaScript.Chrome.Windows.WindowType (WindowType)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/windows

foreign import _get :: Int -> {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)} -> Promise Error Window

get :: forall getInfo. Castable getInfo {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)} =>
    Int -> getInfo -> Promise Error Window
get windowId getInfo = _get windowId $ cast getInfo

foreign import _getAll :: {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)} -> Promise Error (Array Window)

getAll :: forall getInfo. Castable getInfo {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)} =>
    getInfo -> Promise Error (Array Window)
getAll getInfo = _getAll $ cast getInfo
