module Jarilo.Fetch
    ( class Fetch
    , fetch
    , module Jarilo.Fetch.Error
    ) where

import Prelude

import Data.Bifunctor (lmap)
import Data.Either (Either(..))
import Data.Foldable (for_)
import Data.Maybe (fromMaybe, maybe)
import Data.Variant (Variant)
import Effect.Class (liftEffect)
import Jarilo.Fetch.Body (class FetchBody, fetchContentType, fetchRequestBody)
import Jarilo.Fetch.Error (FetchError(..))
import Jarilo.Fetch.Error as Error
import Jarilo.Fetch.Method (class FetchMethod, fetchMethod)
import Jarilo.Fetch.Response (class FetchResponse, fetchResponse)
import Jarilo.Fetch.Url (class FetchPath, class FetchQuery, fetchUrl)
import Jarilo.Types (FullRequest, FullRoute, Route)
import JavaScript.Promise (Promise)
import JavaScript.Promise as Promise
import JavaScript.Web.Fetch.Fetch as Fetch
import JavaScript.Web.Fetch.Headers as Headers
import JavaScript.Web.Fetch.RequestInit (RequestInit)
import JavaScript.Web.Fetch.Response (status)
import Literals.Undefined (undefined)
import Prim.Row (class Lacks)
import Type.Proxy (Proxy(..))
import Untagged.Castable (class Castable, cast)
import Untagged.Union (asOneOf)

-- | The classes behind the instance live in the modules under `Jarilo.Fetch`,
-- | which nobody imports: a call site needs them to exist, not to be in scope.
-- |
-- | The prefix goes before the route's own path: an origin, a path the API is
-- | mounted under, both or neither. The options are any part of a
-- | `RequestInit` but the method and body, which the route decides. Headers
-- | given there are sent alongside the Content-Type the route's body names.
-- | A signal among them aborts the fetch, which then fails with `Aborted`.
class Fetch (route :: Route) pathParams queryParams realBody responses
    | route -> pathParams queryParams realBody responses where
    fetch
        :: ∀ options
        .  Castable (Record options) RequestInit
        => Lacks "method" options
        => Lacks "body" options
        => Proxy route
        -> Record pathParams
        -> Record queryParams
        -> realBody
        -> String
        -> Record options
        -> Promise FetchError (Variant responses)

instance
    ( FetchMethod method
    , FetchPath path pathParams
    , FetchQuery query queryParams
    , FetchBody requestBody realBody
    , FetchResponse response responses
    ) =>
    Fetch (FullRoute (FullRequest method path query requestBody) response) pathParams queryParams realBody responses where
    fetch _ pathParams queryParams realBody prefix options = let
        init = cast options :: RequestInit
        in
        case fetchUrl (Proxy :: _ path) (Proxy :: _ query) pathParams queryParams of
        Left value -> Promise.reject $ UnencodableUrl value
        Right url -> do
            headers <- liftEffect do
                headers <- Headers.new init.headers
                for_ (fetchContentType (Proxy :: _ requestBody)) \contentType ->
                    Headers.set "Content-Type" contentType headers
                pure headers
            let
                request :: RequestInit
                request = init
                    { body = fetchRequestBody (Proxy :: _ requestBody) realBody
                        # maybe (asOneOf undefined) asOneOf
                    , headers = asOneOf headers
                    , method = asOneOf $ fetchMethod (Proxy :: _ method)
                    }
            response <- Fetch.fetch (prefix <> url) request # lmap Error.fromRejection
            fetchResponse (Proxy :: _ response) response
                # fromMaybe (Promise.reject $ UnexpectedStatus $ status response)
