module Jarilo.Router.Body where

import Prelude

import Async (Async)
import Data.Bifunctor (lmap)
import Data.Maybe (Maybe(..))
import Jarilo.Types (Body, JsonBody, NoBody)
import JavaScript.Node.Http.IncomingMessage (IncomingMessage)
import Jarilo.Server.Request (readBody)
import Type.Proxy (Proxy)
import Yoga.JSON (class ReadForeign, class WriteForeign, writeJSON)
import Yoga.JSON.Async (readJSON)

data BodyError = CantParseJson String

bodyErrorMessage :: BodyError -> String
bodyErrorMessage (CantParseJson error) = "The body isn't the JSON the route expects: " <> error

class BodyRouter (body :: Body) realBody | body -> realBody where
    bodyRouter :: Proxy body -> IncomingMessage -> Async BodyError realBody
    responseBodyRouter :: Proxy body -> realBody -> String
    -- How the body above is serialized, so the response can say so. Nothing where there
    -- is no body to describe.
    responseContentType :: Proxy body -> Maybe String

instance BodyRouter NoBody Unit where
    bodyRouter _ _ = pure unit
    responseBodyRouter _ _ = mempty
    responseContentType _ = Nothing

instance (ReadForeign realBody, WriteForeign realBody) => BodyRouter (JsonBody realBody) realBody where
    bodyRouter _ body = body # readBody >>= readJSON # lmap (show >>> CantParseJson)
    responseBodyRouter _ body = writeJSON body
    -- JSON is always UTF-8, so the media type carries no charset parameter.
    responseContentType _ = Just "application/json"
