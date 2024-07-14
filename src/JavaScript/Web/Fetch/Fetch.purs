module JavaScript.Web.Fetch.Fetch (fetch, fetch_) where

import JavaScript.Error (Error)
import JavaScript.Web.Fetch.Request (Request)
import JavaScript.Web.Fetch.RequestInit (RequestInit)
import JavaScript.Web.Fetch.Response (Response)
import JavaScript.Web.URL.URL (URL)
import Literals.Undefined (undefined)
import Promisey (Promise)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|), OneOf, UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Web/API/fetch

foreign import _fetch :: String |+| URL |+| Request -> UndefinedOr RequestInit -> Promise Error Response

fetch :: forall resource. InOneOf resource String (URL |+| Request) =>
    resource -> RequestInit -> Promise Error Response
fetch resource options = _fetch (cast resource) (cast options)

fetch_ :: forall resource. InOneOf resource String (OneOf URL Request) =>
    resource -> Promise Error Response
fetch_ resource = _fetch (cast resource) (cast undefined)
