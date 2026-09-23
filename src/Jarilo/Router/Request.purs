module Jarilo.Router.Request where

import Prelude

import Async (Async, fromEither)
import Data.Bifunctor (lmap)
import Data.Either (Either(..))
import Data.Map (Map)
import Jarilo.Router.Body (class BodyRouter, BodyError, bodyErrorMessage, bodyErrorStatus, bodyRouter)
import Jarilo.Router.Method (class MethodRouter, methodRouter)
import Jarilo.Router.Path (class PathRouter, pathRouter)
import Jarilo.Router.Query (class QueryRouter, QueryError, queryErrorMessage, queryRouter)
import Jarilo.Server.Request (HttpMethod)
import Jarilo.Server.Request as Server
import Jarilo.Types (FullRequest, Request)
import Type.Proxy (Proxy(..))

-- | How a request stands against one route, from its method and path alone.
data RequestMatch pathParams
    = PathMismatch
    | MethodMismatch HttpMethod
    | Match (Record pathParams)

-- | What is wrong with a request its route has matched. It is the client's
-- | fault either way, where a route that doesn't match is no route at all.
data RequestError
    = QueryError QueryError
    | BodyError BodyError

requestErrorMessage :: RequestError -> String
requestErrorMessage = case _ of
    QueryError error -> queryErrorMessage error
    BodyError error -> bodyErrorMessage error

requestErrorStatus :: RequestError -> Int
requestErrorStatus = case _ of
    QueryError _ -> 400
    BodyError error -> bodyErrorStatus error

type RequestResult pathParams queryParams realBody =
    { path :: Record pathParams
    , query :: Record queryParams
    , headers :: Map String String
    , cookies :: Map String String
    , body :: realBody
    }

class RequestRouter (request :: Request) pathParams queryParams realBody | request -> pathParams queryParams realBody where
    matchRequest
        :: Proxy request
        -> Server.Request
        -> RequestMatch pathParams
    readRequest
        :: Proxy request
        -> Record pathParams
        -> Server.Request
        -> Async RequestError (RequestResult pathParams queryParams realBody)

instance
    ( MethodRouter method
    , PathRouter path () pathParams
    , QueryRouter query () queryParams
    , BodyRouter body realBody
    ) =>
    RequestRouter (FullRequest method path query body) pathParams queryParams realBody where
    matchRequest _ request = let
        routeMethod = methodRouter (Proxy :: _ method)
        in
        case pathRouter (Proxy :: _ path) request.path of
        Left _ -> PathMismatch
        Right pathParams | routeMethod == request.method -> Match pathParams
        Right _ -> MethodMismatch routeMethod
    readRequest _ pathParams { query, headers, cookies, body } = do
        queryParams <- queryRouter (Proxy :: _ query) query # lmap QueryError # fromEither
        realBody <- bodyRouter (Proxy :: _ body) headers body # lmap BodyError
        pure
            { path: pathParams
            , query: queryParams
            , headers
            , cookies
            , body: realBody
            }
