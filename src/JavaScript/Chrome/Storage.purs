module JavaScript.Chrome.Storage where

import Data.Unit (Unit)
import Effect (Effect)
import Foreign (Foreign)
import Foreign.Object (Object)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Chrome.Storage.StorageArea (StorageArea)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/storage

foreign import local :: StorageArea

foreign import managed :: StorageArea

foreign import session :: StorageArea

foreign import sync :: StorageArea

-- | A single changed storage item. `oldValue` is absent (reads as `undefined`)
-- | when the item was newly added; `newValue` is absent when it was removed. The
-- | values are arbitrary stored JSON, hence `Foreign` — which already admits
-- | `undefined`, so the absent cases need no further wrapping.
type StorageChange = {oldValue :: Foreign, newValue :: Foreign}

-- | Fires when one or more items in the sync storage area change. The listener
-- | receives a changes object keyed by the changed storage keys.
foreign import syncOnChanged :: Event "storage.sync.onChanged" (Object StorageChange -> Effect Unit)
