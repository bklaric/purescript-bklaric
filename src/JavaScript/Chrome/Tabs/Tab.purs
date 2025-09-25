module JavaScript.Chrome.Tabs.Tab (Tab, id, url, incognito, index, windowId) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/tabs/Tab

-- Tab objects are immutable snapshots that represent tab state in a particular moment.
foreign import data Tab :: Type

foreign import _id :: Tab -> Nullable Int

id :: Tab -> Maybe Int
id tab = _id tab # toMaybe

foreign import _url :: Tab -> Nullable String

url :: Tab -> Maybe String
url tab = _url tab # toMaybe

foreign import incognito :: Tab -> Boolean

foreign import index :: Tab -> Int

foreign import windowId :: Tab -> Int
