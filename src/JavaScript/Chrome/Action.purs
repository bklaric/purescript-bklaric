module JavaScript.Chrome.Action where

import Prelude

import Effect (Effect)
import Foreign (Foreign)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Chrome.Tabs.Tab (Tab)
import Prim.Row (class Union)
import Undefined (undefined)
import Yoga.JSON (class WriteForeign, write)

foreign import setBadgeTextImpl :: Foreign -> Effect Unit -> Effect Unit

setBadgeText :: forall details details'.
    WriteForeign (Record details) => Union details details' (tabId :: Int, text :: String) =>
    Record details -> Effect Unit -> Effect Unit
setBadgeText details callback = setBadgeTextImpl (write details) callback

setBadgeText_ :: forall details details'.
    WriteForeign (Record details) => Union details details' (tabId :: Int, text :: String) =>
    Record details -> Effect Unit
setBadgeText_ details = setBadgeText details undefined

setBadgeText__ :: String -> Effect Unit
setBadgeText__ text = setBadgeText_ {text}

foreign import onClicked :: Event "action.onClicked" ((Tab -> Effect Unit) -> Effect Unit)
