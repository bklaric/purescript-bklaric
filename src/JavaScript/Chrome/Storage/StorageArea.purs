module JavaScript.Chrome.Storage.StorageArea (StorageArea, getAll, getByKey, getByKeys, getWithDefault, set)  where

import Prelude

import JavaScript.Error (Error)
import Foreign (Foreign)
import Promisey (Promise)
import Undefined (undefined)
import ValidJson (class ValidJson)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/storage/StorageArea

foreign import data StorageArea :: Type

foreign import getImpl :: forall query result. query -> StorageArea -> Promise Error result

getAll :: StorageArea -> Promise Error Foreign
getAll = getImpl undefined

getByKey :: String -> StorageArea -> Promise Error Foreign
getByKey = getImpl

getByKeys :: Array String -> StorageArea -> Promise Error Foreign
getByKeys = getImpl

getWithDefault :: forall fields. ValidJson (Record fields) =>
    (Record fields) -> StorageArea -> Promise Error (Record fields)
getWithDefault = getImpl

foreign import setImpl :: forall fields. Record fields -> StorageArea -> Promise Error Unit

set :: forall fields. ValidJson (Record fields) => Record fields -> StorageArea -> Promise Error Unit
set = setImpl
