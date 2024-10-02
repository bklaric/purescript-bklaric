module Postgres.Error
    ( Error
    , length
    , severity
    , detail
    , schemaImpl
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

foreign import schemaImpl :: Error -> Nullable String

schema :: Error -> Maybe String
schema = schemaImpl >>> toMaybe

foreign import tableImpl :: Error -> Nullable String

table :: Error -> Maybe String
table = tableImpl >>> toMaybe

foreign import constraintImpl :: Error -> Nullable String

constraint :: Error -> Maybe String
constraint = constraintImpl >>> toMaybe
