module Jarilo.Fetch.Error (FetchError(..), fromRejection) where

import Prelude

import JavaScript.Error (Error, message, name)

-- | Why a fetch has no response the route declares.
data FetchError
    -- The request never got a response: the network, DNS or CORS.
    = NetworkError Error
    -- The signal passed in the options aborted it.
    | Aborted
    -- The response has a status the route doesn't declare.
    | UnexpectedStatus Int
    -- The status is declared, and the body isn't what the route says it is.
    | UnreadableBody Int String
    -- A path capture or query value can't be percent-encoded: it holds a lone
    -- surrogate, which no URL can carry.
    | UnencodableUrl String

instance Show FetchError where
    show = case _ of
        NetworkError error -> "The request got no response: " <> message error
        Aborted -> "The request was aborted."
        UnexpectedStatus code ->
            "The route declares no response with status " <> show code <> "."
        UnreadableBody code error ->
            "The " <> show code <> " response's body isn't what the route declares: " <> error
        UnencodableUrl value ->
            "The value " <> show value <> " can't be encoded into a URL."

-- The fetch and the read of its body reject the same ways, and an abort is
-- the one a caller that passed a signal expects.
fromRejection :: Error -> FetchError
fromRejection error
    | name error == "AbortError" = Aborted
    | otherwise = NetworkError error
