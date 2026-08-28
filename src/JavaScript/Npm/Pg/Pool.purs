module JavaScript.Npm.Pg.Pool
    ( Pool
    , PoolConfig
    , create
    , totalCount
    , idleCount
    , waitingCount
    , ClientWithRelease
    , connect
    , end
    ) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import JavaScript.Npm.Pg.Client (Client, ClientConfigRow)
import JavaScript.Npm.Pg.Error (Error)
import JavaScript.Npm.Pg.Query (class Querier, defaultQuery, defaultQueryWithConfig)
import JavaScript.Promise (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

-- https://node-postgres.com/apis/pool

foreign import data Pool :: Type

instance EventEmitter Pool where
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

instance Querier Pool where
    query           = defaultQuery
    queryWithConfig = defaultQueryWithConfig

-- The pool hands its config on to every client it creates, so the client
-- fields live in the same record, mirroring pg's PoolConfig.
type PoolConfig = Record (ClientConfigRow
    ( max :: UndefinedOr Int
    , min :: UndefinedOr Int
    , idleTimeoutMillis :: UndefinedOr Int
    , maxUses :: UndefinedOr Int
    , maxLifetimeSeconds :: UndefinedOr Int
    , allowExitOnIdle :: UndefinedOr Boolean
    -- More fields exist.
    ))

foreign import _create :: PoolConfig -> Effect Pool

create :: forall config. Castable config PoolConfig => config -> Effect Pool
create config = _create (cast config)

foreign import totalCount :: Pool -> Effect Int

foreign import idleCount :: Pool -> Effect Int

foreign import waitingCount :: Pool -> Effect Int

type ClientWithRelease =
    { client :: Client
    , releaseClient :: Effect Unit
    -- Drop the connection instead of recycling it. Used when a client cannot be
    -- handed back clean -- a failed ROLLBACK leaves an open transaction, and
    -- returning that client to the pool would strand its locks and give the next
    -- checkout a dirty transaction. Destroying the socket makes Postgres abort it.
    , destroyClient :: Effect Unit
    }

foreign import connect :: Pool -> Promise Error ClientWithRelease

foreign import end :: Pool -> Promise Error Unit
