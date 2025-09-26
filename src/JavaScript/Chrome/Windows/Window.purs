module JavaScript.Chrome.Windows.Window (Window, incognito, sessionId, tabs) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import JavaScript.Chrome.Tabs.Tab (Tab)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/windows/Window

-- Window objects are immutable snapshots that represent window state in a particular moment.
foreign import data Window :: Type

foreign import incognito :: Window -> Boolean

foreign import _tabs :: Window -> Nullable (Array Tab)

foreign import _sessionId :: Window -> Nullable String

sessionId :: Window -> Maybe String
sessionId = _sessionId >>> toMaybe

tabs :: Window -> Maybe (Array Tab)
tabs = _tabs >>> toMaybe
