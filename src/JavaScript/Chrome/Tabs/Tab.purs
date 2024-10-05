module JavaScript.Chrome.Tabs.Tab (Tab, id, url) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/tabs/Tab

foreign import data Tab :: Type

foreign import _id :: Tab -> Effect (Nullable Int)

id :: Tab -> Effect (Maybe Int)
id tab = _id tab <#> toMaybe

foreign import _url :: Tab -> Effect (Nullable String)

url :: Tab -> Effect (Maybe String)
url tab = _url tab <#> toMaybe
