module JavaScript.Web.Clipboard.ClipboardItem where

import Foreign.Object (Object)
import JavaScript.Web.File.Blob (Blob)

-- https://developer.mozilla.org/en-US/docs/Web/API/ClipboardItem

foreign import data ClipboardItem :: Type

foreign import new :: Object Blob -> ClipboardItem
