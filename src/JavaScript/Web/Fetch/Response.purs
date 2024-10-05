module JavaScript.Web.Fetch.Response where

import Foreign (Foreign)
import JavaScript.Error (Error)
import JavaScript.Web.File.Blob (Blob)
import JavaScript.Promise (Promise)

-- https://developer.mozilla.org/en-US/docs/Web/API/Response

foreign import data Response :: Type

foreign import status :: Response -> Int

foreign import text :: Response -> Promise Error String

foreign import json :: Response -> Promise Error Foreign

foreign import blob :: Response -> Promise Error Blob
