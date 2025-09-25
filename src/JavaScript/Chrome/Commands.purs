module JavaScript.Chrome.Commands where

import Prelude

import Effect (Effect)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Chrome.Tabs.Tab (Tab)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/commands

foreign import onCommand :: Event "commands.onCommand" (String -> Tab -> Effect Unit)
