module JavaScript.Chrome.Runtime where

import Prelude

import JavaScript.Chrome.Runtime.MessageSender (MessageSender)
import JavaScript.Chrome.Runtime.OnInstalledReason (OnInstalledReason)
import JavaScript.Chrome.Shared.Event (Event)
import Data.Maybe (Maybe(..), maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign (Foreign)
import JavaScript.Error (Error)
import Literals.Undefined (undefined)
import Promisey (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)
import Yoga.JSON (class ReadForeign, class WriteForeign, read_, write)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/runtime

foreign import _sendMessage ::
    UndefinedOr String -> Foreign -> UndefinedOr {includeTlsChannelId :: UndefinedOr Boolean} -> Promise Error (Nullable Foreign)

sendMessage :: forall extensionId message options response
    .  Castable extensionId (UndefinedOr String)
    => WriteForeign message
    => Castable options (UndefinedOr {includeTlsChannelId :: UndefinedOr Boolean})
    => ReadForeign response
    => extensionId -> message -> options -> Promise Error (Maybe response)
sendMessage extensionId message options =
    _sendMessage (cast extensionId) (write message) (cast options)
    <#> (toMaybe >>> maybe Nothing read_)

sendMessage_ :: forall message response. WriteForeign message => ReadForeign response =>
    message -> Promise Error (Maybe response)
sendMessage_ message = sendMessage undefined message undefined

sendMessage__ :: forall message. WriteForeign message =>
    message -> Promise Error Unit
sendMessage__ message = _sendMessage (cast undefined) (write message) (cast undefined) # void

-- Doesn't work in content scripts.
foreign import openOptionsPage :: Promise Error Unit

foreign import getManifest :: Effect Foreign

foreign import id :: Effect String

foreign import getURL :: String -> Effect String

foreign import setUninstallURL :: String -> Promise Error Unit

foreign import reload :: Effect Unit

foreign import onMessage :: Event "runtime.onMessage" (Foreign -> MessageSender -> (Foreign -> Effect Unit) -> Effect Boolean)

foreign import onSuspend :: Event "runtime.onSuspend" (Effect Unit)

foreign import onUpdateAvailable :: Event "runtime.onUpdateAvailable" ({version :: String} -> Effect Unit)

foreign import onInstalled :: Event "runtime.onInstalled"
    ({id :: Nullable String, previousVersion :: Nullable String, reason :: OnInstalledReason, temporary :: Boolean} -> Effect Unit)
