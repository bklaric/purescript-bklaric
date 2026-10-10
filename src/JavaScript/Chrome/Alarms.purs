module JavaScript.Chrome.Alarms (Alarm, AlarmInfo, create, get, onAlarm) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/alarms

-- | `scheduledTime` is in milliseconds since the epoch, hence `Number`.
type Alarm =
    { name :: String
    , scheduledTime :: Number
    , periodInMinutes :: UndefinedOr Number
    }

type AlarmInfo =
    { when :: UndefinedOr Number
    , delayInMinutes :: UndefinedOr Number
    , periodInMinutes :: UndefinedOr Number
    }

foreign import _create :: String -> AlarmInfo -> Promise Error Unit

-- | Creating an alarm with the name of an existing one replaces it and restarts its schedule.
create :: forall info. Castable info AlarmInfo => String -> info -> Promise Error Unit
create name info = _create name (cast info)

-- | Resolves with `undefined` when there is no alarm with that name, which `toMaybe` reads as `Nothing`.
foreign import _get :: String -> Promise Error (Nullable Alarm)

get :: String -> Promise Error (Maybe Alarm)
get name = _get name <#> toMaybe

foreign import onAlarm :: Event "alarms.onAlarm" (Alarm -> Effect Unit)
