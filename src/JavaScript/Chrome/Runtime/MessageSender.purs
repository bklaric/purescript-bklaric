module JavaScript.Chrome.Runtime.MessageSender (MessageSender, tab) where

import Prelude

import JavaScript.Chrome.Tabs.Tab (Tab)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/runtime/MessageSender

foreign import data MessageSender :: Type

foreign import tabImpl :: MessageSender -> Effect (Nullable Tab)

tab :: MessageSender -> Effect (Maybe Tab)
tab messageSender = tabImpl messageSender <#> toMaybe
