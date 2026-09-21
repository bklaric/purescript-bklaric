module Jarilo.Fetch.Response (class FetchResponse, fetchResponse) where

import Prelude

import Control.Alt ((<|>))
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol)
import Data.Variant (Variant, expand, inj)
import Jarilo.Fetch.Body (class FetchBody, fetchResponseBody)
import Jarilo.Fetch.Error (FetchError)
import Jarilo.Shared.Status (class StatusCode, statusCode)
import Jarilo.Types (FullResponse, Response, ResponseChain)
import JavaScript.Promise (Promise)
import JavaScript.Web.Fetch.Response (status)
import JavaScript.Web.Fetch.Response as FetchRes
import Prim.Row (class Cons, class Union)
import Type.Proxy (Proxy(..))

-- | Nothing where the response's status is none the route declares; otherwise
-- | the reading of its body, which fails only on the body.
class FetchResponse (response :: Response) (results :: Row Type) | response -> results where
    fetchResponse :: Proxy response -> FetchRes.Response -> Maybe (Promise FetchError (Variant results))

instance
    ( StatusCode status label
    , IsSymbol label
    , Cons label realBody () results
    , FetchBody body realBody
    ) =>
    FetchResponse (FullResponse status body) results where
    fetchResponse _ response = let
        code = statusCode (Proxy :: _ status)
        in
        if status response == code
        then Just $ fetchResponseBody (Proxy :: _ body) code response <#> inj (Proxy :: _ label)
        else Nothing

instance
    ( FetchResponse leftResponse leftResults
    , FetchResponse rightResponse rightResults
    , Union leftResults rightResults results
    , Union rightResults leftResults results
    ) =>
    FetchResponse (ResponseChain leftResponse rightResponse) results where
    fetchResponse _ response =
        (fetchResponse (Proxy :: _ leftResponse) response <#> map expand)
        <|> (fetchResponse (Proxy :: _ rightResponse) response <#> map expand)
