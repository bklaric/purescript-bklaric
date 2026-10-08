module JavaScript.Intl.DateTimeFormat (DateTimeFormat, Options, ResolvedOptions, new, new_, new_', new__, format, resolvedOptions) where

import Data.Either (Either(..))
import Effect (Effect)
import JavaScript.Date (Date)
import JavaScript.Error (Error)
import Literals (StringLit)
import Literals.Undefined (Undefined, undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl/DateTimeFormat

foreign import data DateTimeFormat :: Type

type Options = {dateStyle :: StringLit "full" |+| StringLit "long" |+| StringLit "medium" |+| StringLit "short" |+| Undefined}

-- The fields resolvedOptions always has; the rest depend on the options given.
type ResolvedOptions =
    { locale :: String
    , calendar :: String
    , numberingSystem :: String
    , timeZone :: String
    }

-- Making a DateTimeFormat is an Effect: whatever the options leave out comes
-- from the runtime's locale and time zone as they are at that moment. Once made
-- it is immutable, so format and resolvedOptions are pure.
foreign import _new
    :: (Error -> Either Error DateTimeFormat)
    -> (DateTimeFormat -> Either Error DateTimeFormat)
    -> String
    -> UndefinedOr Options
    -> Effect (Either Error DateTimeFormat)

-- Fails on a locale that isn't a well-formed language tag. A well-formed one
-- the runtime lacks falls back to its default.
new :: forall options. Castable options (UndefinedOr Options) => String -> options -> Effect (Either Error DateTimeFormat)
new locale options = _new Left Right locale (cast options)

new_ :: String -> Effect (Either Error DateTimeFormat)
new_ locale = _new Left Right locale (cast undefined)

foreign import _newDefaultLocale :: UndefinedOr Options -> Effect DateTimeFormat

-- The runtime's own locale, which leaves nothing to fail on: Options only
-- admits values Intl accepts.
new_' :: forall options. Castable options (UndefinedOr Options) => options -> Effect DateTimeFormat
new_' options = _newDefaultLocale (cast options)

-- The runtime's own locale and time zone, which leave nothing to fail on.
foreign import new__ :: Effect DateTimeFormat

foreign import format :: Date -> DateTimeFormat -> String

foreign import resolvedOptions :: DateTimeFormat -> ResolvedOptions
