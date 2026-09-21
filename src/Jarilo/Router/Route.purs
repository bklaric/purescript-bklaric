module Jarilo.Router.Route where

import Prelude

import Async (Async)
import Data.Array.NonEmpty (NonEmptyArray, singleton)
import Data.Bifunctor (lmap)
import Data.Variant (class VariantMatchCases, Variant)
import Jarilo.Router.Request (class RequestRouter, RequestError, RequestMatch(..), RequestResult, matchRequest, readRequest)
import Jarilo.Router.Response (class ResponseRouter, responseRouter)
import Jarilo.Server.Request (HttpMethod)
import Jarilo.Server.Request (Request) as Server
import Jarilo.Server.Response (Response) as Server
import Jarilo.Types (FullRoute, Route)
import Prim.Row (class Union)
import Prim.RowList (class RowToList)
import Type.Proxy (Proxy(..))

-- | How a request stands against a set of routes. The first route whose method
-- | and path both match takes the request, and from then on any fault in it is
-- | the request's, never a reason to try another route.
data RouteMatch
    = Unmatched
    | PathMatched (NonEmptyArray HttpMethod)
    | Matched (Async RequestError Server.Response)

-- | Tries the second only where the first has no route for the request.
orElse :: RouteMatch -> (Unit -> RouteMatch) -> RouteMatch
orElse first second = case first of
    Matched _ -> first
    Unmatched -> second unit
    PathMatched methods -> case second unit of
        Matched response -> Matched response
        Unmatched -> PathMatched methods
        PathMatched moreMethods -> PathMatched (methods <> moreMethods)

class RouteRouter (route :: Route) handler | route -> handler where
    routeRouter :: Proxy route -> handler -> Server.Request -> RouteMatch

-- A handler cannot fail: whatever goes wrong in it is one of its responses.
instance
    ( RequestRouter request pathParams queryParams realBody
    , ResponseRouter response () responseHandlerRow
    , RowToList responseHandlerRow responseHandlerRowList
    , VariantMatchCases responseHandlerRowList wtf Server.Response
    , Union wtf () responseRow
    ) =>
    RouteRouter
        (FullRoute request response)
        (RequestResult pathParams queryParams realBody -> Async Void (Variant responseRow))
    where
    routeRouter _ handler request =
        case matchRequest (Proxy :: _ request) request of
        PathMismatch -> Unmatched
        MethodMismatch method -> PathMatched $ singleton method
        Match pathParams -> Matched do
            requestResult <- readRequest (Proxy :: _ request) pathParams request
            handler requestResult
                # lmap absurd
                <#> responseRouter (Proxy :: _ response)
