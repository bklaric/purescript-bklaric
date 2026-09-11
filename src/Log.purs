module Log (datetimeFormat, logStamped, logt) where

import Prelude

import Data.Formatter.DateTime (FormatterCommand(..), format)
import Data.List (List(..), (:))
import Effect (Effect)
import Effect.Console (log)
import Effect.Now (nowDateTime)

datetimeFormat :: List FormatterCommand
datetimeFormat =
    YearFull : Placeholder "-" :
    MonthTwoDigits : Placeholder "-" :
    DayOfMonthTwoDigits : Placeholder " " :
    Hours24 : Placeholder ":" :
    MinutesTwoDigits : Placeholder ":" :
    SecondsTwoDigits : Nil

-- | Logs the line prefixed with the local date and time.
logStamped :: String -> Effect Unit
logStamped string =
    nowDateTime
    <#> format datetimeFormat
    >>= \dateTime -> log $ dateTime <> " - " <> string

-- | Logs an indented continuation line under a preceding `logStamped`.
logt :: String -> Effect Unit
logt string = log $ "    " <> string
