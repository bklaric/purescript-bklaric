module Jarilo.Router.Body where

import Prelude

import Async (Async, left)
import Data.Array (head)
import Data.Bifunctor (lmap)
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe(..), maybe)
import Data.String (Pattern(..), split, toLower, trim)
import Jarilo.Types (Body, JsonBody, NoBody)
import JavaScript.Node.Http.IncomingMessage (IncomingMessage)
import Jarilo.Server.Request (readBody)
import Type.Proxy (Proxy)
import Yoga.JSON (class ReadForeign, class WriteForeign, writeJSON)
import Yoga.JSON.Async (readJSON)

data BodyError
    = NotLabelledJson (Maybe String)
    | CantParseJson String

bodyErrorMessage :: BodyError -> String
bodyErrorMessage = case _ of
    NotLabelledJson contentType ->
        "The body is labelled " <> maybe "nothing" show contentType <> ", not application/json."
    CantParseJson error -> "The body isn't the JSON the route expects: " <> error

bodyErrorStatus :: BodyError -> Int
bodyErrorStatus = case _ of
    NotLabelledJson _ -> 415
    CantParseJson _ -> 400

-- A form another site posts can carry JSON, but a browser labels a form's body
-- only as a form or as text, and lets another site send application/json only
-- after asking this one. Taking nothing else keeps other sites from sending a
-- route its body with the cookies of whoever is browsing them.
labelledJson :: Map String String -> Boolean
labelledJson headers =
    Map.lookup "content-type" headers
    <#> (split (Pattern ";") >>> head >>> maybe "" (trim >>> toLower))
    # eq (Just "application/json")

class BodyRouter (body :: Body) realBody | body -> realBody where
    bodyRouter :: Proxy body -> Map String String -> IncomingMessage -> Async BodyError realBody
    responseBodyRouter :: Proxy body -> realBody -> String
    -- How the body above is serialized, so the response can say so. Nothing where there
    -- is no body to describe.
    responseContentType :: Proxy body -> Maybe String

instance BodyRouter NoBody Unit where
    bodyRouter _ _ _ = pure unit
    responseBodyRouter _ _ = mempty
    responseContentType _ = Nothing

instance (ReadForeign realBody, WriteForeign realBody) => BodyRouter (JsonBody realBody) realBody where
    bodyRouter _ headers body
        | labelledJson headers = body # readBody >>= readJSON # lmap (show >>> CantParseJson)
        | otherwise = left $ NotLabelledJson $ Map.lookup "content-type" headers
    responseBodyRouter _ body = writeJSON body
    -- JSON is always UTF-8, so the media type carries no charset parameter.
    responseContentType _ = Just "application/json"
