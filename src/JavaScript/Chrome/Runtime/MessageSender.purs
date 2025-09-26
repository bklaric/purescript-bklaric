module JavaScript.Chrome.Runtime.MessageSender (MessageSender, tab) where

import Prelude

import JavaScript.Chrome.Tabs.Tab (Tab)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/runtime/MessageSender

foreign import data MessageSender :: Type

foreign import _tab :: MessageSender -> Nullable Tab

tab :: MessageSender -> Maybe Tab
tab messageSender = _tab messageSender # toMaybe
