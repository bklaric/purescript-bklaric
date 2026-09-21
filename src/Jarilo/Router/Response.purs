module Jarilo.Router.Response where

import Prelude

import Data.Maybe (Maybe(..))
import Data.MultiMap (MultiMap, insertOrReplace')
import Data.Symbol (class IsSymbol)
import Data.Variant (class VariantMatchCases, Variant, match)
import Jarilo.Router.Body (class BodyRouter, responseBodyRouter, responseContentType)
import Jarilo.Server.Response as Server
import Jarilo.Shared.Status (class StatusCode, statusCode)
import Jarilo.Types (FullResponse, Response, ResponseChain)
import Prim.Row (class Cons, class Lacks, class Union)
import Prim.RowList (class RowToList)
import Record.Builder (Builder, buildFromScratch, insert)
import Type.Proxy (Proxy(..))

data AppResponse realBody = AppResponse (MultiMap String String) realBody

type ResponseConverter realBody = AppResponse realBody -> Server.Response

responseRouter''
    :: ∀ label responsesStart responsesEnd body realBody
    .  Cons label (ResponseConverter realBody) responsesStart responsesEnd
    => Lacks label responsesStart
    => IsSymbol label
    => BodyRouter body realBody
    => Proxy label
    -> Proxy body
    -> Int
    -> Builder (Record responsesStart) (Record responsesEnd)
responseRouter'' labelProxy bodyProxy statusCode = insert labelProxy
    \(AppResponse headers body) ->
        { statusCode
        -- The route type is what decides how the body is serialized, so it is also what
        -- gets to name the media type.
        , headers: case responseContentType bodyProxy of
            Just contentType -> insertOrReplace' "Content-Type" contentType headers
            Nothing -> headers
        , body: responseBodyRouter bodyProxy body
        }

class ResponseRouter (response :: Response) responsesStart responsesEnd | response -> responsesStart responsesEnd where
    responseRouter'
        :: Proxy response
        -> Builder (Record responsesStart) (Record responsesEnd)

instance
    ( StatusCode status label
    , IsSymbol label
    , Lacks label responsesStart
    , Cons label (ResponseConverter realBody) responsesStart responsesEnd
    , BodyRouter body realBody
    ) =>
    ResponseRouter (FullResponse status body) responsesStart responsesEnd where
    responseRouter' _ = responseRouter''
        (Proxy :: _ label) (Proxy :: _ body) (statusCode (Proxy :: _ status))

instance (ResponseRouter leftResponse responsesStart responsesMid, ResponseRouter rightResponse responsesMid responsesEnd) =>
    ResponseRouter (ResponseChain leftResponse rightResponse) responsesStart responsesEnd where
    responseRouter' _ = responseRouter' (Proxy :: _ leftResponse) >>> responseRouter' (Proxy :: _ rightResponse)

responseRouter
    :: ∀ responseHandlerRowList wtf responseRow response responseHandlerRow
    .  RowToList responseHandlerRow responseHandlerRowList
    => VariantMatchCases responseHandlerRowList wtf Server.Response
    => Union wtf () responseRow
    => ResponseRouter response () responseHandlerRow
    => Proxy response
    -> Variant responseRow -> Server.Response
responseRouter proxy response = response # match (responseRouter' proxy # buildFromScratch)
