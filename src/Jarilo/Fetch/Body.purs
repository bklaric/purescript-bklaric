module Jarilo.Fetch.Body
    ( class FetchBody
    , fetchContentType
    , fetchRequestBody
    , fetchResponseBody
    ) where

import Prelude

import Data.Bifunctor (lmap)
import Data.Maybe (Maybe(..))
import Jarilo.Fetch.Error (FetchError(..), fromRejection)
import Jarilo.Types (Body, JsonBody, NoBody)
import JavaScript.Promise (Promise)
import JavaScript.Promise as Promise
import JavaScript.Web.Fetch.Response (Response, text)
import Type.Proxy (Proxy)
import Yoga.JSON (class ReadForeign, class WriteForeign, readJSON, writeJSON)

class FetchBody (body :: Body) realBody | body -> realBody where
    fetchRequestBody :: Proxy body -> realBody -> Maybe String
    -- How the request body above is serialized, so the request can say so.
    -- Nothing where there is no body to describe.
    fetchContentType :: Proxy body -> Maybe String
    fetchResponseBody :: Proxy body -> Int -> Response -> Promise FetchError realBody

instance FetchBody NoBody Unit where
    fetchRequestBody _ _ = Nothing
    fetchContentType _ = Nothing
    fetchResponseBody _ _ _ = pure unit

instance (WriteForeign realBody, ReadForeign realBody) => FetchBody (JsonBody realBody) realBody where
    fetchRequestBody _ realBody = Just $ writeJSON realBody
    -- JSON is always UTF-8, so the media type carries no charset parameter.
    fetchContentType _ = Just "application/json"
    fetchResponseBody _ code response = do
        body <- text response # lmap fromRejection
        readJSON body # lmap (show >>> UnreadableBody code) # Promise.fromEither
