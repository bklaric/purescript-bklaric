module JavaScript.Chrome.Windows (create, get, get_, getAll) where

import Prelude

import JavaScript.Chrome.Windows.Window (Window)
import JavaScript.Chrome.Windows.WindowType (WindowType)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Literals.Undefined (Undefined, undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/windows

foreign import _create :: UndefinedOr {incognito :: UndefinedOr Boolean, url :: Undefined |+| String |+| Array String} -> Promise Error Window

create :: forall a24.
  Castable a24 (UndefinedOr {incognito :: UndefinedOr Boolean, url :: Undefined |+| String |+| Array String})
   => a24 -> Promise Error Window
create createInfo = _create $ cast createInfo

foreign import _get :: Int -> UndefinedOr {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)} -> Promise Error Window

get :: forall getInfo. Castable getInfo (UndefinedOr {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)}) =>
    Int -> getInfo -> Promise Error Window
get windowId getInfo = _get windowId $ cast getInfo

get_ :: Int -> Promise Error Window
get_ windowId = _get windowId $ cast undefined

foreign import _getAll :: {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)} -> Promise Error (Array Window)

getAll :: forall getInfo. Castable getInfo {populate :: UndefinedOr Boolean, windowTypes :: UndefinedOr (Array WindowType)} =>
    getInfo -> Promise Error (Array Window)
getAll getInfo = _getAll $ cast getInfo
