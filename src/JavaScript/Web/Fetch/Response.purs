module JavaScript.Web.Fetch.Response where

import Foreign (Foreign)
import JavaScript.ArrayBuffer (ArrayBuffer)
import JavaScript.Error (Error)
import JavaScript.Web.File.Blob (Blob)
import JavaScript.Promise (Promise)

-- https://developer.mozilla.org/en-US/docs/Web/API/Response

foreign import data Response :: Type

foreign import status :: Response -> Int

-- | Whether the status is in the 2xx range. The one check almost every caller
-- | wants, and cheaper to read at a call site than a hand-rolled range test.
foreign import ok :: Response -> Boolean

foreign import statusText :: Response -> String

foreign import text :: Response -> Promise Error String

foreign import json :: Response -> Promise Error Foreign

foreign import blob :: Response -> Promise Error Blob

foreign import arrayBuffer :: Response -> Promise Error ArrayBuffer
