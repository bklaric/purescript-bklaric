module JavaScript.Npm.Pg.Client
    ( Client
    , ClientConfigRow
    , ClientConfig
    , create
    , connect
    , end
    ) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import JavaScript.Npm.Pg.Error (Error)
import JavaScript.Npm.Pg.Query (class Querier, defaultQuery, defaultQueryWithConfig)
import JavaScript.Promise (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

-- https://node-postgres.com/apis/client

foreign import data Client :: Type

instance EventEmitter Client where
    on                  = EventEmitter.defaultOn
    once                = EventEmitter.defaultOnce
    prependListener     = EventEmitter.defaultPrependListener
    prependOnceListener = EventEmitter.defaultPrependOnceListener
    removeListener      = EventEmitter.defaultRemoveListener
    removeAllListeners  = EventEmitter.defaultRemoveAllListeners
    emit                = EventEmitter.defaultEmit
    listeners           = EventEmitter.defaultListeners
    listenerCount       = EventEmitter.defaultListenerCount
    getMaxListeners     = EventEmitter.defaultGetMaxListeners
    setMaxListeners     = EventEmitter.defaultSetMaxListeners
    eventNames          = EventEmitter.defaultEventNames

instance Querier Client where
    query           = defaultQuery
    queryWithConfig = defaultQueryWithConfig

-- Every field falls back to the libpq PG* environment variables, which is
-- how the services here configure their connections. Keys keep pg's own
-- spelling (snake_case included) because the record is handed to the
-- constructor as-is.
type ClientConfigRow otherFields =
    ( user :: UndefinedOr String
    , password :: UndefinedOr String
    , host :: UndefinedOr String
    , port :: UndefinedOr Int
    , database :: UndefinedOr String
    , connectionString :: UndefinedOr String
    , ssl :: UndefinedOr Boolean
    , statement_timeout :: UndefinedOr Int
    , query_timeout :: UndefinedOr Int
    , lock_timeout :: UndefinedOr Int
    , idle_in_transaction_session_timeout :: UndefinedOr Int
    , connectionTimeoutMillis :: UndefinedOr Int
    , application_name :: UndefinedOr String
    , keepAlive :: UndefinedOr Boolean
    -- More fields exist.
    | otherFields
    )

type ClientConfig = Record (ClientConfigRow ())

foreign import _create :: ClientConfig -> Effect Client

create :: forall config. Castable config ClientConfig => config -> Effect Client
create config = _create (cast config)

-- pg resolves connect with the client itself, which the caller already
-- holds, so it is dropped rather than typed.
foreign import connect :: Client -> Promise Error Unit

foreign import end :: Client -> Promise Error Unit
