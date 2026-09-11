module JavaScript.Npm.Pg.Client.Transaction
    ( begin
    , commit
    , rollback
    , withTransaction
    ) where

import Prelude

import Data.Bifunctor (lmap)
import JavaScript.Npm.Pg.Client (Client)
import JavaScript.Npm.Pg.Error (Error)
import JavaScript.Npm.Pg.Query (Query(..), execute_)
import JavaScript.Promise (Promise, catch, reject, thenOrCatch)

-- https://node-postgres.com/features/transactions

begin :: Client -> Promise Error Unit
begin = execute_ (Query "begin")

commit :: Client -> Promise Error Unit
commit = execute_ (Query "commit")

rollback :: Client -> Promise Error Unit
rollback = execute_ (Query "rollback")

-- | Runs the callback between `begin` and `commit` on a single client, rolling
-- | back if it fails. A failed rollback is not reported: the caller is owed the
-- | error that actually broke the transaction, and the connection is discarded
-- | either way.
withTransaction
    :: forall error result
    .  (Error -> error)
    -> (Client -> Promise error result)
    -> Client
    -> Promise error result
withTransaction constructError callback client =
    (begin client # lmap constructError)
    *> (callback client # catch \error ->
        rollback client
        # thenOrCatch (const $ reject error) (const $ reject error))
    >>= \result -> (commit client # lmap constructError) $> result
