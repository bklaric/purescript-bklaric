module JavaScript.Npm.Pg.Pool.Events where

import Prelude

import Effect (Effect)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Npm.Pg.Client (Client)
import JavaScript.Npm.Pg.Error (Error)
import JavaScript.Npm.Pg.Pool (Pool)

-- https://node-postgres.com/apis/pool#events

connect :: Event Pool (Client -> Effect Unit)
connect = Event "connect"

acquire :: Event Pool (Client -> Effect Unit)
acquire = Event "acquire"

error :: Event Pool (Error -> Client -> Effect Unit)
error = Event "error"

remove :: Event Pool (Client -> Effect Unit)
remove = Event "remove"
