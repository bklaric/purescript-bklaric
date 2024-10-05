module JavaScript.Chrome.Menus.OnClickData (OnClickData, menuItemId, srcUrl) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Untagged.Union (type (|+|))

foreign import data OnClickData :: Type

foreign import menuItemId :: OnClickData -> Int |+| String

foreign import srcUrlImpl :: OnClickData -> Nullable String

srcUrl :: OnClickData -> Maybe String
srcUrl = srcUrlImpl >>> toMaybe
