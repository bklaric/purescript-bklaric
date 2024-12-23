module JavaScript.Chrome.Storage.StorageArea (StorageArea, getAll, getByKey, getByKeys, getWithDefault, set, remove)  where

import Prelude

import Foreign (Foreign)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Literals.Undefined (Undefined, undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))
import ValidJson (class ValidJson)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/storage/StorageArea

foreign import data StorageArea :: Type

foreign import _get :: forall fields. Undefined |+| String |+| Array String |+| Record fields -> StorageArea -> Promise Error Foreign

getAll :: StorageArea -> Promise Error Foreign
getAll = _get $ cast undefined

getByKey :: String -> StorageArea -> Promise Error Foreign
getByKey = _get <<< cast

getByKeys :: Array String -> StorageArea -> Promise Error Foreign
getByKeys = _get <<< cast

getWithDefault :: forall fields. ValidJson (Record fields) =>
    Record fields -> StorageArea -> Promise Error Foreign
getWithDefault record area = area # _get (cast record :: Undefined |+| String |+| Array String |+| Record fields)

foreign import _set :: forall fields. Record fields -> StorageArea -> Promise Error Unit

set :: forall fields. ValidJson (Record fields) => Record fields -> StorageArea -> Promise Error Unit
set = _set

foreign import _remove :: String |+| Array String -> StorageArea -> Promise Error Unit

remove :: forall keys. Castable keys (String |+| Array String) => keys -> StorageArea -> Promise Error Unit
remove = _remove <<< cast
