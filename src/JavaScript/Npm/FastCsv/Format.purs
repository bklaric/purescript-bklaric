module JavaScript.Npm.FastCsv.Format (WriteOptions, writeToString) where

import JavaScript.Error (Error)
import JavaScript.Promise (Promise)

-- https://www.npmjs.com/package/@fast-csv/format

type WriteOptions =
    { headers :: Array String
    }

-- One array of cells per row, written with the formatter's own quoting and
-- escaping -- which is the reason to reach for it over string concatenation for
-- any value that could hold a quote, a delimiter or a newline.
foreign import writeToString :: WriteOptions -> Array (Array String) -> Promise Error String
