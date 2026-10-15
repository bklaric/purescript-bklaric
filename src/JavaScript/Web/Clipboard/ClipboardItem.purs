module JavaScript.Web.Clipboard.ClipboardItem where

import Effect (Effect)
import Foreign.Object (Object)
import JavaScript.Promise (Promise)
import JavaScript.Web.File.Blob (Blob)

-- https://developer.mozilla.org/en-US/docs/Web/API/ClipboardItem

foreign import data ClipboardItem :: Type

foreign import new :: Object Blob -> ClipboardItem

-- | An item whose data is still being produced. Writing it right away checks the write against
-- | the user activation that is current then, rather than against whatever is left of it once the
-- | data is ready. Effectful because it starts the promises.
foreign import fromPromises :: forall left. Object (Promise left Blob) -> Effect ClipboardItem
