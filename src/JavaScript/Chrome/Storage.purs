module JavaScript.Chrome.Storage where

import JavaScript.Chrome.Storage.StorageArea (StorageArea)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/storage

foreign import local :: StorageArea

foreign import managed :: StorageArea

foreign import session :: StorageArea

foreign import sync :: StorageArea
