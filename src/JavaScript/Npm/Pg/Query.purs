module JavaScript.Npm.Pg.Query
    ( Query(..)
    , QueryParameter
    , cons
    , (:)
    , finalCons
    , (:|)
    , RowMode(..)
    , QueryConfig(..)
    , class Querier
    , query
    , query_
    , queryWithConfig
    , defaultQuery
    , defaultQueryWithConfig
    , execute
    , execute_
    ) where

import Prelude

import Data.Array as Array
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toNullable)
import JavaScript.Npm.Pg.Error (Error)
import JavaScript.Npm.Pg.Result (Result)
import JavaScript.Promise (Promise)
import Unsafe.Coerce (unsafeCoerce)

-- https://node-postgres.com/apis/client#clientquery

newtype Query = Query String

derive newtype instance Semigroup Query

foreign import data QueryParameter :: Type

cons :: forall parameter.
    parameter -> Array QueryParameter -> Array QueryParameter
cons parameter parameters = Array.cons (unsafeCoerce parameter) parameters

infixr 6 cons as :

finalCons :: forall leftParameter rightParameter.
    leftParameter -> rightParameter -> Array QueryParameter
finalCons left right = left : [unsafeCoerce right]

infixr 6 finalCons as :|

data RowMode = KeyValue | Array

rowModeToNullableString :: RowMode -> Nullable String
rowModeToNullableString Array = toNullable $ Just "array"
rowModeToNullableString KeyValue = toNullable Nothing

newtype QueryConfig = QueryConfig
    { text :: Query
    , values :: Maybe (Array QueryParameter)
    , name :: Maybe String
    , rowMode :: RowMode
    }

newtype QueryConfigImpl = QueryConfigImpl
    { text :: Query
    , values :: Nullable (Array QueryParameter)
    , name :: Nullable String
    , rowMode :: Nullable String
    }

fromQueryConfig :: QueryConfig -> QueryConfigImpl
fromQueryConfig (QueryConfig queryConfig) = QueryConfigImpl
    { text: queryConfig.text
    , values: toNullable queryConfig.values
    , name: toNullable queryConfig.name
    , rowMode: rowModeToNullableString queryConfig.rowMode }

-- A Pool checks a client out per query; a Client runs it on its one
-- connection, which is what transactions need.
class Querier querier where
    query :: Query -> Array QueryParameter -> querier -> Promise Error Result
    queryWithConfig :: QueryConfig -> querier -> Promise Error Result

foreign import defaultQuery
    :: forall querier
    .  Query
    -> Array QueryParameter
    -> querier
    -> Promise Error Result

foreign import _queryWithConfig
    :: forall querier
    .  QueryConfigImpl
    -> querier
    -> Promise Error Result

defaultQueryWithConfig
    :: forall querier
    .  QueryConfig
    -> querier
    -> Promise Error Result
defaultQueryWithConfig queryConfig querier =
    _queryWithConfig (fromQueryConfig queryConfig) querier

query_ :: forall querier. Querier querier =>
    Query -> querier -> Promise Error Result
query_ queryString querier = query queryString [] querier

execute :: forall querier. Querier querier =>
    Query -> Array QueryParameter -> querier -> Promise Error Unit
execute query' parameters querier = query query' parameters querier # void

execute_ :: forall querier. Querier querier =>
    Query -> querier -> Promise Error Unit
execute_ query' querier = query_ query' querier # void
