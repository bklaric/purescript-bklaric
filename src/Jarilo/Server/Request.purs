module Jarilo.Server.Request (HttpMethod, Request, readBody, readRequest) where

import Prelude

import Async (Async, fromEffectCont)
import Control.Monad.Except (runExcept)
import Data.Array (mapMaybe)
import Data.Foldable (all, and)
import Data.Either (Either, hush)
import Data.HTTP.Method (CustomMethod, Method)
import Data.HTTP.Method as Method
import Data.List (List(..), fromFoldable, (:))
import Data.Map (Map)
import Data.Map as Map
import Data.Maybe (Maybe(..), fromMaybe, isJust, maybe)
import Data.String (Pattern(..), drop, indexOf, split, splitAt, trim)
import Data.String.NonEmpty (toString)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..))
import Foreign (Foreign, readString)
import Foreign.Object as Object
import JSURI (decodeURIComponent)
import JavaScript.Node.Buffer (concat_, toString___)
import JavaScript.Node.Http.IncomingMessage (IncomingMessage, headers, method, url)
import JavaScript.Node.Stream.Readable.Events (collectDataEvents)
import Parsing (Parser, fail, runParser)
import Parsing.Combinators (optionMaybe)
import Parsing.String (eof)
import Unsafe.Coerce (unsafeCoerce)
import URI (PathAbsolute(..))
import URI.Common (wrapParser)
import URI.Extra.QueryPairs (Key, QueryPairs(..), Value, unsafeKeyToString, unsafeValueToString)
import URI.Extra.QueryPairs as QueryPairs
import URI.Path.Absolute as PathAbsolute
import URI.Path.Segment (PathSegment, unsafeSegmentFromString, unsafeSegmentNZToString, unsafeSegmentToString)
import URI.Query as Query

type HttpMethod = Either Method CustomMethod

-- | What routing reads from a request. The body is left unread: only the route
-- | the request is committed to reads it, and a stream can be read only once.
type Request =
    { method :: HttpMethod
    , path :: List PathSegment
    , query :: QueryPairs Key Value
    , headers :: Map String String
    , cookies :: Map String String
    , body :: IncomingMessage
    }

type Url = { path :: List PathSegment, query :: QueryPairs Key Value }

toSegments :: PathAbsolute -> List PathSegment
toSegments = case _ of
    PathAbsolute (Just (Tuple first rest)) ->
        (first # unsafeSegmentNZToString # toString # unsafeSegmentFromString)
        : fromFoldable rest
    PathAbsolute Nothing -> Nil

decodes :: String -> Boolean
decodes = decodeURIComponent >>> isJust

-- The routers decode segments, keys and values with the uri package, which
-- throws on an escape that isn't UTF-8, such as a lone `%C3`. Checking them all
-- here is what lets the routers decode without it.
decodesAll :: Url -> Boolean
decodesAll { path, query: QueryPairs pairs } = and
    [ path # all (unsafeSegmentToString >>> decodes)
    , pairs # all \(Tuple key value) ->
        decodes (unsafeKeyToString key)
        && maybe true (unsafeValueToString >>> decodes) value
    ]

-- The whole target has to parse. A parser that stops early would route what it
-- read and silently drop the rest.
urlParser :: Parser String Url
urlParser = do
    path <- PathAbsolute.parse <#> toSegments
    query <- optionMaybe $ wrapParser (QueryPairs.parse pure pure) Query.parser
    eof
    let parsed = { path, query: fromMaybe (QueryPairs []) query }
    if decodesAll parsed then pure parsed else fail "An escape doesn't decode."

readString' :: Foreign -> Maybe String
readString' = readString >>> runExcept >>> hush

-- Node types `headers` with every value it may hold. The ones sent as arrays,
-- such as set-cookie, never arrive on a request.
readHeaders :: IncomingMessage -> Map String String
readHeaders message =
    headers message
    # Object.toUnfoldable
    # mapMaybe (traverse readString')
    # Map.fromFoldable

-- A cookie value may itself contain `=`, so only the first one splits the pair.
readCookie :: String -> Maybe (Tuple String String)
readCookie pair = indexOf (Pattern "=") pair <#> \index -> let
    { before, after } = splitAt index pair
    in
    Tuple (trim before) (drop 1 after)

readCookies :: Map String String -> Map String String
readCookies headers' =
    Map.lookup "cookie" headers'
    # maybe Map.empty (split (Pattern ";") >>> mapMaybe readCookie >>> Map.fromFoldable)

-- | Nothing when the request target is not a path with an optional query, as
-- | with `OPTIONS *` or a target in absolute form, or when an escape in it
-- | doesn't decode.
readRequest :: IncomingMessage -> Maybe Request
readRequest message = do
    { path, query } <- url message >>= (flip runParser urlParser >>> hush)
    let headers' = readHeaders message
    pure
        { method: method message # fromMaybe "" # Method.fromString
        , path
        , query
        , headers: headers'
        , cookies: readCookies headers'
        , body: message
        }

readBody :: ∀ left. IncomingMessage -> Async left String
readBody message = fromEffectCont \callback ->
    message
    # collectDataEvents (map unsafeCoerce >>> concat_ >=> toString___ >=> callback)
    # void
