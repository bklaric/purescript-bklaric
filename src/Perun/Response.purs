module Perun.Response where

import Prelude

import Data.Array (fromFoldable)
import Data.MultiMap (MultiMap, toUnfoldable)
import Data.Tuple (Tuple(..))
import Effect (Effect, foreachE)
import JavaScript.Node.Http.ServerResponse (ServerResponse, setHeader', setStatusCode)
import JavaScript.Node.Stream.Writable (endString__)

type Response =
    { statusCode :: Int
    , headers :: MultiMap String String
    , body :: String
    }

respond :: ServerResponse -> Response -> Effect Unit
respond response { statusCode, headers, body } = do
    setStatusCode statusCode response
    foreachE (toUnfoldable headers) \(Tuple header values) ->
        setHeader' header (fromFoldable values) response
    endString__ body response # void
