module JavaScript.Npm.Pg.Pool.Transaction (withTransaction) where

import Prelude

import Data.Bifunctor (lmap)
import JavaScript.Npm.Pg.Client (Client)
import JavaScript.Npm.Pg.Client.Transaction as Client
import JavaScript.Npm.Pg.Error (Error)
import JavaScript.Npm.Pg.Pool (Pool, connect)
import JavaScript.Promise (Promise, finally, fromEffect)

-- | Checks a client out of the pool for the length of the transaction, so every
-- | statement in it lands on one connection, and returns it however that ends.
withTransaction
    :: forall error result
    .  (Error -> error)
    -> (Client -> Promise error result)
    -> Pool
    -> Promise error result
withTransaction constructError callback pool =
    (connect pool # lmap constructError)
    >>= \{ client, releaseClient } ->
        Client.withTransaction constructError callback client
        # finally (fromEffect releaseClient)
