module Postgres.Error
    ( Error
    , length
    , severity
    , detail
    , _schema
    , schema
    , table
    , constraint
    ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import JavaScript.Class (class Error)
import JavaScript.Node.Errors.Class (class NodeError, defaultCode)

foreign import data Error :: Type

instance Error Error

instance NodeError Error where
    code = defaultCode

foreign import length :: Error -> Int

foreign import severity :: Error -> String

foreign import detail :: Error -> String

foreign import _schema :: Error -> Nullable String

schema :: Error -> Maybe String
schema = _schema >>> toMaybe

foreign import _table :: Error -> Nullable String

table :: Error -> Maybe String
table = _table >>> toMaybe

foreign import _constraint :: Error -> Nullable String

constraint :: Error -> Maybe String
constraint = _constraint >>> toMaybe
