module JavaScript.Web.Fetch.Fetch (fetch, fetch_) where

import JavaScript.Error (Error)
import JavaScript.Web.Fetch.Request (Request)
import JavaScript.Web.Fetch.RequestInit (RequestInit)
import JavaScript.Web.Fetch.Response (Response)
import JavaScript.Web.URL.URL (URL)
import Literals.Undefined (undefined)
import JavaScript.Promise (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Web/API/fetch

foreign import _fetch :: String |+| URL |+| Request -> UndefinedOr RequestInit -> Promise Error Response

fetch :: forall resource options.
    Castable resource (String |+| URL |+| Request) =>
    Castable options (UndefinedOr RequestInit) =>
    resource -> options -> Promise Error Response
fetch resource options = _fetch (cast resource) (cast options)

fetch_ :: forall resource. Castable resource (String |+| URL |+| Request) =>
    resource -> Promise Error Response
fetch_ resource = _fetch (cast resource) (cast undefined)
