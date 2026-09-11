-- | The `Async` face of `JavaScript.Web.Fetch.Fetch`, for callers that thread
-- | `Async` rather than `Promise`. Every export is the promise-returning
-- | original run through `promiseToAsync`.
module JavaScript.Web.Fetch.Async
    ( fetch
    , fetch_
    , text
    , json
    , blob
    , arrayBuffer
    ) where

import Prelude

import Async (Async)
import Async.Promisey (promiseToAsync)
import Foreign (Foreign)
import JavaScript.ArrayBuffer (ArrayBuffer)
import JavaScript.Error (Error)
import JavaScript.Web.Fetch.Fetch as Fetch
import JavaScript.Web.Fetch.Request (Request)
import JavaScript.Web.Fetch.RequestInit (RequestInit)
import JavaScript.Web.Fetch.Response (Response)
import JavaScript.Web.Fetch.Response as Response
import JavaScript.Web.File.Blob (Blob)
import JavaScript.Web.URL.URL (URL)
import Untagged.Castable (class Castable)
import Untagged.Union (type (|+|), UndefinedOr)

fetch :: forall resource options.
    Castable resource (String |+| URL |+| Request) =>
    Castable options (UndefinedOr RequestInit) =>
    resource -> options -> Async Error Response
fetch resource options = Fetch.fetch resource options # promiseToAsync

fetch_ :: forall resource. Castable resource (String |+| URL |+| Request) =>
    resource -> Async Error Response
fetch_ resource = Fetch.fetch_ resource # promiseToAsync

text :: Response -> Async Error String
text response = Response.text response # promiseToAsync

json :: Response -> Async Error Foreign
json response = Response.json response # promiseToAsync

blob :: Response -> Async Error Blob
blob response = Response.blob response # promiseToAsync

arrayBuffer :: Response -> Async Error ArrayBuffer
arrayBuffer response = Response.arrayBuffer response # promiseToAsync
