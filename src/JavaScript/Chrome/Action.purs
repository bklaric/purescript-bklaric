module JavaScript.Chrome.Action where

import Prelude

import Effect (Effect)
import Foreign (Foreign)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Chrome.Tabs.Tab (Tab)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Prim.Row (class Union)
import Yoga.JSON (class WriteForeign, write)

foreign import setBadgeTextImpl :: Foreign -> Promise Error Unit

setBadgeText :: forall details details'.
    WriteForeign (Record details) => Union details details' (tabId :: Int, text :: String) =>
    Record details -> Promise Error Unit
setBadgeText details = setBadgeTextImpl (write details)

setBadgeText_ :: String -> Promise Error Unit
setBadgeText_ text = setBadgeText {text}

foreign import onClicked :: Event "action.onClicked" ((Tab -> Effect Unit) -> Effect Unit)
