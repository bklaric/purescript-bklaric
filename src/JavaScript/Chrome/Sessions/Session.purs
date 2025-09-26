module JavaScript.Chrome.Sessions.Session (Session, lastModified, tab, window) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import JavaScript.Chrome.Tabs.Tab (Tab)
import JavaScript.Chrome.Windows.Window (Window)

foreign import data Session :: Type

foreign import lastModified :: Session -> Int

foreign import _tab :: Session -> Nullable Tab

tab :: Session -> Maybe Tab
tab = _tab >>> toMaybe

foreign import _window :: Session -> Nullable Window

window :: Session -> Maybe Window
window = _window >>> toMaybe
