-- | The `Async` face of the `pg` bindings, for callers that thread `Async`
-- | rather than `Promise`. Every export is the promise-returning original run
-- | through `promiseToAsync`.
module JavaScript.Npm.Pg.Async
    ( query
    , query_
    , execute
    , execute_
    , connect
    , end
    , withTransaction
    ) where

import Prelude

import Async (Async)
import Async.Promisey (asyncToPromise, promiseToAsync)
import JavaScript.Npm.Pg.Client (Client)
import JavaScript.Npm.Pg.Error (Error)
import JavaScript.Npm.Pg.Pool (ClientWithRelease, Pool)
import JavaScript.Npm.Pg.Pool as Pool
import JavaScript.Npm.Pg.Pool.Transaction as Transaction
import JavaScript.Npm.Pg.Query (class Querier, Query, QueryParameter)
import JavaScript.Npm.Pg.Query as Query
import JavaScript.Npm.Pg.Result (Result)

query :: forall querier. Querier querier =>
    Query -> Array QueryParameter -> querier -> Async Error Result
query queryString parameters querier =
    Query.query queryString parameters querier # promiseToAsync

query_ :: forall querier. Querier querier =>
    Query -> querier -> Async Error Result
query_ queryString querier = Query.query_ queryString querier # promiseToAsync

execute :: forall querier. Querier querier =>
    Query -> Array QueryParameter -> querier -> Async Error Unit
execute queryString parameters querier =
    Query.execute queryString parameters querier # promiseToAsync

execute_ :: forall querier. Querier querier =>
    Query -> querier -> Async Error Unit
execute_ queryString querier = Query.execute_ queryString querier # promiseToAsync

connect :: Pool -> Async Error ClientWithRelease
connect pool = Pool.connect pool # promiseToAsync

end :: Pool -> Async Error Unit
end pool = Pool.end pool # promiseToAsync

withTransaction
    :: forall error result
    .  (Error -> error)
    -> (Client -> Async error result)
    -> Pool
    -> Async error result
withTransaction constructError callback pool =
    Transaction.withTransaction constructError (callback >>> asyncToPromise) pool
    # promiseToAsync
