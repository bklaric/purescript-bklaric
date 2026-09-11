module Jarilo.Serve where

import Prelude

import Async (examineLeftWithEffect, unify)
import Data.Bifunctor (lmap)
import Data.Either (Either)
import Data.HTTP.Method (CustomMethod, Method)
import Data.List (List)
import Data.Map (Map)
import Effect (Effect)
import Jarilo.Router.Junction (class JunctionRouter, junctionRouter)
import JavaScript.Node.Net.Server (IpcListenOptions, TcpListenOptions)
import Log (logStamped)
import Perun.Async.Server (run_)
import Perun.Request (Request)
import Record.Extra (pick)
import Type.Proxy (Proxy)
import URI.Extra.QueryPairs (Key, QueryPairs, Value)
import URI.Path.Segment (PathSegment)
import Untagged.Union (class InOneOf)

type ShowableRequest =
    { method :: Either CustomMethod Method
    , path :: List PathSegment
    , query :: QueryPairs Key Value
    , cookies :: Map String String
    }

serve
    :: ∀ errors handlers junction options
    .  JunctionRouter junction errors handlers
    => InOneOf options TcpListenOptions IpcListenOptions
    => Proxy junction -> options -> Record handlers -> Effect Unit
serve proxy options handlers =
    run_ options \request ->
        junctionRouter proxy handlers request
        # examineLeftWithEffect (const $ logStamped $ show $ (pick :: Request -> ShowableRequest) request)
        # lmap (const { statusCode: 404, headers: mempty, body: mempty })
        # unify
