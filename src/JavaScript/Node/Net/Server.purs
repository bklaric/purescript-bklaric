module JavaScript.Node.Net.Server
    ( class Server
    , CommonListenOptions
    , TcpListenOptions
    , IpcListenOptions
    , ListenOptions
    , close
    , listen
    , listen_
    , listenTcpPHBL
    , listenTcpP___
    , listenTcp____
    , listenIpcPBL
    , listening
    ) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import Literals.Undefined (undefined)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|), UndefinedOr)

-- https://nodejs.org/api/net.html#class-netserver

class EventEmitter server <= Server server

-- listen

type CommonListenOptions =
    ( backlog :: UndefinedOr Int
    , exclusive :: UndefinedOr Boolean
    , ipv6Only :: UndefinedOr Boolean
    -- , signal :: UndefinedOr AbortSignal
    )

type TcpListenOptions =
    { port :: Int
    , host :: UndefinedOr String
    | CommonListenOptions
    }

type IpcListenOptions =
    { path :: String
    | CommonListenOptions
    }

type ListenOptions = TcpListenOptions |+| IpcListenOptions

foreign import listenImpl :: forall server.
    ListenOptions -> Effect Unit -> server -> Effect server

listen :: forall options server. Server server => InOneOf options TcpListenOptions IpcListenOptions =>
    options -> Effect Unit -> server -> Effect server
listen listenOptions listeningListener server =
    listenImpl (cast listenOptions) listeningListener server

listen_ :: forall server options. Server server => InOneOf options TcpListenOptions IpcListenOptions =>
    options -> server -> Effect server
listen_ listenOptions server = listen listenOptions (pure unit) server

foreign import listenTcpImpl :: forall server.
    UndefinedOr Int -> UndefinedOr String -> UndefinedOr Int -> UndefinedOr (Effect Unit) -> server -> Effect server

listenTcpPHBL :: forall server. Server server =>
    Int -> String -> Int -> Effect Unit -> server -> Effect server
listenTcpPHBL port host backlog listeningListener server =
    listenTcpImpl (cast port) (cast host) (cast backlog) (cast listeningListener) server

listenTcpP___ :: forall server. Server server =>
    Int -> server -> Effect server
listenTcpP___ port server =
    listenTcpImpl (cast port) (cast undefined) (cast undefined) (cast undefined) server

listenTcp____ :: forall server. Server server =>
    server -> Effect server
listenTcp____ server =
    listenTcpImpl (cast undefined) (cast undefined) (cast undefined) (cast undefined) server

foreign import listenIpcImpl :: forall server.
    UndefinedOr String -> UndefinedOr Int -> UndefinedOr (Effect Unit) -> server -> Effect server

listenIpcPBL :: forall server. Server server =>
    String -> Int -> Effect Unit -> server -> Effect server
listenIpcPBL path backlog listeningListener server =
    listenIpcImpl (cast path) (cast backlog) (cast listeningListener) server

-- events

close :: forall server. Server server => Event server (Effect Unit)
close = Event "close"

listening :: forall server. Server server => Event server (Effect Unit)
listening = Event "listening"
