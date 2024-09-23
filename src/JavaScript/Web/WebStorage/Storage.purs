module JavaScript.Web.WebStorage.Storage where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)

foreign import data Storage :: Type

-- | Returns the number of items in the storage.
foreign import length :: Storage -> Effect Int

foreign import _key :: Int -> Storage -> Effect (Nullable String)

-- | Retrieves the key at the given index in the storage, if one exists.
key :: Int -> Storage -> Effect (Maybe String)
key i = map toMaybe <<< _key i

foreign import _getItem :: String -> Storage -> Effect (Nullable String)

-- | Retrieves the value stored at the given key, if one exists.
getItem :: String -> Storage -> Effect (Maybe String)
getItem s = map toMaybe <<< _getItem s

-- | Given a key name and a value (in that order), adds that key to the
-- | storage or updates its value if it already exists.
-- Can throw if it runs out of space.
foreign import setItem :: String -> String -> Storage -> Effect Unit

-- | Removes the given key from the storage.
foreign import removeItem :: String -> Storage -> Effect Unit

-- | Clears all keys from the storage.
foreign import clear :: Storage -> Effect Unit
