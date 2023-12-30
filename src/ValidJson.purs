module ValidJson where

import Data.Nullable (Nullable)
import Data.Variant (Variant)
import Literal (Literal)
import Prim.RowList (class RowToList, Cons, Nil)
import Untagged.Union (OneOf)

class ValidJson :: forall k. k -> Constraint
class ValidJson json

instance ValidJson String

instance ValidJson Char

instance ValidJson Int

instance ValidJson Number

instance ValidJson Boolean

instance ValidJson json => ValidJson (Array json)

instance (RowToList row list, ValidJson list) => ValidJson (Record row)

instance (RowToList row list, ValidJson list) => ValidJson (Variant row)

instance ValidJson (Nil)
else instance (ValidJson json, ValidJson list) => ValidJson (Cons symbol json list)

instance (ValidJson a, ValidJson b) => ValidJson (OneOf a b)

instance ValidJson a => ValidJson (Nullable a)

instance ValidJson (Literal symbol)
