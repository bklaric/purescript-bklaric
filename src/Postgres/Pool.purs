module Postgres.Pool
    ( Pool
    , create
    , totalCount
    , idleCount
    , waitingCount
    , ClientWithRelease
    , connect
    , end) where

import Prelude

import Data.Either (Either(..))
import Foreign (Foreign)
import Data.Options (Options, options)
import Effect (Effect)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import Postgres.Client (Client)
import Postgres.Client.Config (ClientConfig)
import Postgres.Error (Error)
import Postgres.Pool.Config (PoolConfig)
import Postgres.Query (class Querier, defaultQuery, defaultQueryWithConfig)
import Unsafe.Coerce (unsafeCoerce)

foreign import data Pool :: Type

instance EventEmitter.EventEmitter Pool where
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

foreign import _create :: Foreign -> Effect Pool

create :: Options PoolConfig -> Options ClientConfig -> Effect Pool
create poolConfig clientConfig =
    poolConfig <> unsafeCoerce clientConfig # options # _create

foreign import totalCount :: Pool -> Effect Int

foreign import idleCount :: Pool -> Effect Int

foreign import waitingCount :: Pool -> Effect Int

foreign import _connect
    :: (Error -> Effect Unit)
    -> (Client -> Effect Unit -> Effect Unit -> Effect Unit)
    -> Pool
    -> Effect Unit

type ClientWithRelease =
    { client :: Client
    , releaseClient :: Effect Unit
    -- Drop the connection instead of recycling it. Used when a client cannot be
    -- handed back clean -- a failed ROLLBACK leaves an open transaction, and
    -- returning that client to the pool would strand its locks and give the next
    -- checkout a dirty transaction. Destroying the socket makes Postgres abort it.
    , destroyClient :: Effect Unit
    }

connect ::
    (Either Error ClientWithRelease -> Effect Unit) -> Pool -> Effect Unit
connect callback pool =
    _connect
        (Left >>> callback)
        (\client releaseClient destroyClient ->
            { client, releaseClient, destroyClient } # Right # callback)
        pool

foreign import end :: Effect Unit -> Pool -> Effect Unit
