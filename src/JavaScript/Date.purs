module JavaScript.Date (Date, toISOString, getTime, getUTCFullYear, getUTCMonth, getUTCDate) where

import Prelude

import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign (Foreign, ForeignError(..), fail, tagOf)
import Yoga.JSON (class ReadForeign)

-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date

foreign import data Date :: Type

foreign import readDateImpl :: Foreign -> Nullable Date

-- A driver that hands back a real Date -- node-postgres does this for timestamptz
-- columns -- can be decoded straight into a record field alongside its string
-- columns, rather than pulled out of the row separately.
instance ReadForeign Date where
    readImpl value = case toMaybe (readDateImpl value) of
        Just date -> pure date
        Nothing -> fail (TypeMismatch "Date" (tagOf value))

-- Effectful because it throws on an invalid date, which is the one thing the
-- other accessors below answer with NaN instead.
foreign import toISOString :: Date -> Effect String

-- Milliseconds since the epoch. A Number rather than an Int because the value
-- has been outside Int's 32-bit range since 1970 plus 25 days.
foreign import getTime :: Date -> Number

foreign import getUTCFullYear :: Date -> Int

-- 0-based, as in JavaScript.
foreign import getUTCMonth :: Date -> Int

foreign import getUTCDate :: Date -> Int
