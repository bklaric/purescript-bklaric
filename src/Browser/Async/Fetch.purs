module Browser.Async.Fetch (module Browser.Fetch, fetch, fetch_) where

import Prelude

import Async (Async, fromEitherCont)
import Browser.Fetch (Credentials(..), FetchOptions, FetchOptionsRow)
import Browser.Fetch as F
import Browser.Fetch.Response (Response)
import JavaScript.Error (Error)
import Prim.Row (class Union)

fetch :: forall options options'. Union options options' FetchOptionsRow =>
    String -> Record options -> Async Error Response
fetch url options = F.fetch url options # fromEitherCont

fetch_ :: String -> Async Error Response
fetch_ url = F.fetch_ url # fromEitherCont
