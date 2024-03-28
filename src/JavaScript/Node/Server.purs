module JavaScript.Node.Server
    ( CommonListenOptions
    , ListenOptions(..)
    , class Server
    , close
    , defaultListen
    , listen
    , listen_
    , listening
    ) where

import Prelude

import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
import Data.Maybe (Maybe(..))
import Data.Nullable (Nullable, toNullable)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Node.Events.EventEmitter (class EventEmitter)

type ListenImplOptions =
    { path :: Nullable String
    , port :: Nullable Int
    , host :: Nullable String
    , backlog :: Nullable Int
    , exclusive :: Nullable Boolean
    }

type CommonListenOptions =
    ( backlog :: Maybe Int
    , exclusive :: Maybe Boolean
    )

data ListenOptions
    = IpcListenOptions
        { path :: String
        | CommonListenOptions
        }
    | TcpListenOptions
        { port :: Maybe Int
        , host :: Maybe String
        | CommonListenOptions
        }

toListenImplOptions :: ListenOptions -> ListenImplOptions
toListenImplOptions (IpcListenOptions ipcListenOptions) =
    { path: toNullable $ Just ipcListenOptions.path
    , port: toNullable Nothing
    , host: toNullable Nothing
    , backlog: toNullable ipcListenOptions.backlog
    , exclusive: toNullable ipcListenOptions.exclusive
    }
toListenImplOptions (TcpListenOptions tcpListenOptions) =
    { path: toNullable Nothing
    , port: toNullable tcpListenOptions.port
    , host: toNullable tcpListenOptions.host
    , backlog: toNullable tcpListenOptions.backlog
    , exclusive: toNullable tcpListenOptions.exclusive
    }

class EventEmitter server <= Server server where
    listen :: ListenOptions -> Effect Unit -> server -> Effect Unit

foreign import listenImpl ::
    ListenImplOptions -> Effect Unit -> Foreign -> Effect Unit

defaultListen :: forall server.
    ListenOptions -> Effect Unit -> server -> Effect Unit
defaultListen listenOptions listeningListener server = let
    listenImplOptions = toListenImplOptions listenOptions
    foreignServer = unsafeToForeign server
    in
    listenImpl listenImplOptions listeningListener foreignServer

listen_ :: forall server. Server server =>
    ListenOptions -> server -> Effect Unit
listen_ listenOptions server = listen listenOptions (pure unit) server

close :: forall server. Server server => Event server (Effect Unit)
close = Event "close"

listening :: forall server. Server server => Event server (Effect Unit)
listening = Event "listening"
