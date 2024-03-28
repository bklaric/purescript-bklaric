module JavaScript.Web.Clipboard.Clipboard where

import Prelude

import JavaScript.Error (Error)
import JavaScript.Web.Clipboard.ClipboardItem (ClipboardItem)
import Promisey (Promise)

-- https://developer.mozilla.org/en-US/docs/Web/API/Clipboard

foreign import data Clipboard :: Type

-- It actually throws a DOMException instead of an Error.
foreign import write :: Array ClipboardItem -> Clipboard -> Promise Error Unit
