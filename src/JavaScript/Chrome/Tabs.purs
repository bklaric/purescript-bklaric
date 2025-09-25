module JavaScript.Chrome.Tabs (sendMessage, sendMessage_, sendMessage__, get, getCurrent, CreateProperties, create, UpdateProperties, update, update_, query, onCreated, onUpdated, onRemoved, onMoved) where

import Prelude

import Data.Maybe (Maybe(..), maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign (Foreign)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Chrome.Tabs.Tab (Tab)
import JavaScript.Chrome.Tabs.TabStatus (TabStatus)
import JavaScript.Chrome.Windows.WindowType (WindowType)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Literals.Undefined (Undefined, undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)
import Yoga.JSON (class ReadForeign, class WriteForeign, read_, write)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/tabs

foreign import _sendMessage ::
    Int -> Foreign -> UndefinedOr {frameId :: UndefinedOr Int} -> Promise Error (Nullable Foreign)

sendMessage :: forall message options response
    .  WriteForeign message
    => Castable options (UndefinedOr {frameId :: UndefinedOr Int})
    => ReadForeign response
    => Int -> message -> options -> Promise Error (Maybe response)
sendMessage tabId message options =
    _sendMessage tabId (write message) (cast options)
    <#> (toMaybe >>> maybe Nothing read_)

sendMessage_ :: forall message response. WriteForeign message => ReadForeign response =>
    Int -> message -> Promise Error (Maybe response)
sendMessage_ tabId message = sendMessage tabId message undefined

sendMessage__ :: forall message. WriteForeign message =>
    Int -> message -> Promise Error Unit
sendMessage__ tabId message = _sendMessage tabId (write message) (cast undefined) # void

foreign import get :: Int -> Promise Error Tab

foreign import getCurrent :: Promise Error Tab

type CreateProperties =
    { active :: UndefinedOr Boolean
    , cookieStoreId :: UndefinedOr String
    , discarded :: UndefinedOr Boolean
    , index :: UndefinedOr Int
    , muted :: UndefinedOr Boolean
    , openerTabId :: UndefinedOr Int
    , openInReaderMode :: UndefinedOr Boolean
    , pinned :: UndefinedOr Boolean
    , title :: UndefinedOr String
    , url :: UndefinedOr String
    , windowId :: UndefinedOr Int
    }

foreign import _create :: CreateProperties -> Promise Error Tab

create :: forall properties. Castable properties CreateProperties =>
    properties -> Promise Error Tab
create props = _create $ cast props

type UpdateProperties =
    { active :: UndefinedOr Boolean
    , autoDiscardable :: UndefinedOr Boolean
    , highlighted :: UndefinedOr Boolean
    -- Not supported in Chrome.
    -- , loadReplace :: UndefinedOr Boolean
    , muted :: UndefinedOr Boolean
    , openerTabId :: UndefinedOr Int
    , pinned :: UndefinedOr Boolean
    , successorTabId :: UndefinedOr Int
    , url :: UndefinedOr String
    }

foreign import _update :: UndefinedOr Int -> UpdateProperties -> Promise Error Tab

update :: forall updateProperties. Castable updateProperties UpdateProperties =>
    Int -> updateProperties -> Promise Error Tab
update tabId properties = _update (cast tabId) (cast properties)

update_ :: forall updateProperties. Castable updateProperties UpdateProperties =>
    updateProperties -> Promise Error Tab
update_ properties = _update (cast undefined) (cast properties)

type QueryProperties =
    { active :: UndefinedOr Boolean
    , attention :: UndefinedOr Boolean
    , audible :: UndefinedOr Boolean
    , autoDiscardable :: UndefinedOr Boolean
    , cookieStoreId :: Undefined |+| String |+| Array String
    , currentWindow :: UndefinedOr Boolean
    , hidden :: UndefinedOr Boolean
    , highlighted :: UndefinedOr Boolean
    , discarded :: UndefinedOr Boolean
    , index :: UndefinedOr Int
    , muted :: UndefinedOr Boolean
    , lastFocusedWindow :: UndefinedOr Boolean
    , pinned :: UndefinedOr Boolean
    , status :: UndefinedOr TabStatus
    , title :: UndefinedOr String
    , url :: UndefinedOr String
    , windowId :: UndefinedOr Int
    , currentWindow :: UndefinedOr Boolean
    , windowType :: UndefinedOr WindowType
    }

foreign import _query :: QueryProperties -> Promise Error (Array Tab)

query :: forall queryProperties. Castable queryProperties QueryProperties =>
    queryProperties -> Promise Error (Array Tab)
query = _query <<< cast

foreign import onCreated :: Event "tabs.onCreated" (Tab -> Effect Unit)

foreign import onUpdated :: Event "tabs.onUpdated" (Int -> {url :: Nullable String} -> Tab -> Effect Unit)

foreign import onRemoved :: Event "tabs.onRemoved" (Int -> {windowId :: Int, isWindowClosing :: Boolean} -> Effect Unit)

foreign import onMoved :: Event "tabs.onMoved" (Int -> {windowId :: Int, fromIndex :: Int, toIndex :: Int} -> Effect Unit)
