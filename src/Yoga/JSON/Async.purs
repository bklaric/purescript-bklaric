module Yoga.JSON.Async where

import Prelude

import Async (Async)
import Async as Async
import Foreign (Foreign, MultipleErrors)
import Yoga.JSON (class ReadForeign)
import Yoga.JSON as Json

readJSON :: ∀ read. ReadForeign read =>
    String -> Async MultipleErrors read
readJSON = Json.readJSON >>> Async.fromEither

read :: ∀ read. ReadForeign read =>
    Foreign -> Async MultipleErrors read
read = Json.read >>> Async.fromEither
