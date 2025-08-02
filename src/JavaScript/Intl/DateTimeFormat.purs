module JavaScript.Intl.DateTimeFormat where

import Data.JSDate (JSDate)
import Literals (StringLit)
import Literals.Undefined (Undefined, undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat

foreign import data DateTimeFormat :: Type

type Options = {dateStyle :: StringLit "full" |+| StringLit "long" |+| StringLit "medium" |+| StringLit "short" |+| Undefined}

-- Can actually throw an exception if locales or options are invalid.
-- DateTimeFormat is immutable, so we we're not returning Effect DateTimeFormat.
-- All other functions are pure as well.
foreign import _new :: String -> UndefinedOr Options -> DateTimeFormat

new :: forall options. Castable options (UndefinedOr Options) => String -> options -> DateTimeFormat
new locale options = _new locale (cast options)

new_ :: String -> DateTimeFormat
new_ locale = _new locale (cast undefined)

foreign import format :: JSDate -> DateTimeFormat -> String
