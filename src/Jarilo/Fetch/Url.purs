module Jarilo.Fetch.Url
    ( class FetchPath
    , class FetchQuery
    , fetchPath
    , fetchQuery
    , fetchUrl
    ) where

import Prelude

import Data.Array (null)
import Data.Either (Either, note)
import Data.Foldable (foldMap)
import Data.Maybe (Maybe, maybe)
import Data.String (joinWith)
import Data.Symbol (class IsSymbol, reflectSymbol)
import Data.Traversable (traverse)
import Data.Tuple (Tuple(..))
import JSURI (encodeURIComponent)
import Jarilo.Shared.Component (class Component, toComponent)
import Jarilo.Types (Capture, Literal, Mandatory, Many, NoQuery, Optional, Path, PathChain, Query, QueryChain, Rest)
import Prim.Row (class Cons)
import Record (get)
import Type.Proxy (Proxy(..))

-- | The path's segments, not yet encoded.
class FetchPath (path :: Path) parameters | path -> parameters where
    fetchPath :: Proxy path -> Record parameters -> Array String

instance (IsSymbol name) =>
    FetchPath (Literal name) parameters where
    fetchPath _ _ = [ reflectSymbol (Proxy :: _ name) ]

instance (IsSymbol name, Component value, Cons name value parameters' parameters) =>
    FetchPath (Capture name value) parameters where
    fetchPath _ parameters = [ toComponent (get (Proxy :: _ name) parameters :: value) ]

instance (FetchPath leftPath parameters, FetchPath rightPath parameters) =>
    FetchPath (PathChain leftPath rightPath) parameters where
    fetchPath _ parameters =
        fetchPath (Proxy :: _ leftPath) parameters
        <> fetchPath (Proxy :: _ rightPath) parameters

-- | The query's name and value pairs, not yet encoded.
class FetchQuery (query :: Query) parameters | query -> parameters where
    fetchQuery :: Proxy query -> Record parameters -> Array (Tuple String String)

instance FetchQuery NoQuery parameters where
    fetchQuery _ _ = []

instance (IsSymbol name, Component value, Cons name (Maybe value) parameters' parameters) =>
    FetchQuery (Optional name value) parameters where
    fetchQuery _ parameters =
        get (Proxy :: _ name) parameters
        # maybe [] \value -> [ Tuple (reflectSymbol (Proxy :: _ name)) (toComponent value) ]

instance (IsSymbol name, Component value, Cons name value parameters' parameters) =>
    FetchQuery (Mandatory name value) parameters where
    fetchQuery _ parameters =
        [ Tuple (reflectSymbol (Proxy :: _ name)) (toComponent (get (Proxy :: _ name) parameters :: value)) ]

instance (IsSymbol name, Component value, Cons name (Array value) parameters' parameters) =>
    FetchQuery (Many name value) parameters where
    fetchQuery _ parameters =
        get (Proxy :: _ name) parameters
        <#> \value -> Tuple (reflectSymbol (Proxy :: _ name)) (toComponent value)

instance (IsSymbol name, Component name', Component value, Cons name (Array (Tuple name' value)) parameters' parameters) =>
    FetchQuery (Rest name) parameters where
    fetchQuery _ parameters =
        get (Proxy :: _ name) parameters
        <#> \(Tuple name value) -> Tuple (toComponent name) (toComponent value)

instance (FetchQuery leftQuery parameters, FetchQuery rightQuery parameters) =>
    FetchQuery (QueryChain leftQuery rightQuery) parameters where
    fetchQuery _ parameters =
        fetchQuery (Proxy :: _ leftQuery) parameters
        <> fetchQuery (Proxy :: _ rightQuery) parameters

encode :: String -> Either String String
encode value = encodeURIComponent value # note value

-- | The URL after the origin and prefix, every segment and query name and
-- | value encoded. Left with the value that can't be.
fetchUrl :: ∀ pathParameters queryParameters path query.
    FetchPath path pathParameters => FetchQuery query queryParameters =>
    Proxy path -> Proxy query -> Record pathParameters -> Record queryParameters -> Either String String
fetchUrl pathProxy queryProxy pathParameters queryParameters = do
    segments <- fetchPath pathProxy pathParameters # traverse encode
    pairs <- fetchQuery queryProxy queryParameters # traverse \(Tuple name value) ->
        (\name' value' -> name' <> "=" <> value') <$> encode name <*> encode value
    pure $ foldMap ("/" <> _) segments
        <> if null pairs then "" else "?" <> joinWith "&" pairs
