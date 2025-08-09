module JavaScript.Chrome.Notifications (NotificationOptions, NotificationButton, create, clear, getAll, onClicked, onButtonClicked, onClosed) where

import Prelude

import Effect (Effect)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Literals (StringLit)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

type NotificationButton =
    { title :: String
    }

type NotificationOptions =
    { type :: StringLit "basic"
    , title :: String
    , message :: String
    , iconUrl :: UndefinedOr String
    , buttons :: UndefinedOr (Array NotificationButton)
    , requireInteraction :: UndefinedOr Boolean
    , silent :: UndefinedOr Boolean
    }

foreign import _create :: String -> NotificationOptions -> Promise Error String

create :: forall options. Castable options NotificationOptions =>
    String -> options -> Promise Error String
create id options = _create id (cast options)

foreign import clear :: String -> Promise Error Boolean

foreign import getAll :: Promise Error (Array String)

foreign import onClicked :: Event "notifications.onClicked" (String -> Effect Unit)

foreign import onButtonClicked :: Event "notifications.onButtonClicked" (String -> Int -> Effect Unit)

foreign import onClosed :: Event "notifications.onClosed" (String -> Boolean -> Effect Unit)
