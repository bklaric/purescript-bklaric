module JavaScript.Npm.Pg.Client.Events where

import Prelude

import Effect (Effect)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Npm.Pg.Client (Client)
import Untagged.Union (UndefinedOr)

-- https://node-postgres.com/apis/client#events

-- The payload is UndefinedOr rather than Maybe because the record arrives
-- raw from the emitter; NOTIFY without a payload leaves the field absent.
type Notification =
    { processId :: Int
    , channel :: String
    , payload :: UndefinedOr String
    }

notification :: Event Client (Notification -> Effect Unit)
notification = Event "notification"

end :: Event Client (Effect Unit)
end = Event "end"

notice :: Event Client (String -> Effect Unit)
notice = Event "notice"
