module JavaScript.Chrome.WebRequest (ExtraInfoSpec, addListener, addListener', OnBeforeSendHeadersDetails, onBeforeSendHeaders, OnBeforeRequestDetails, onBeforeRequest, OnCompletedDetails, onCompleted) where

import Prelude

import Data.Nullable (Nullable)
import Effect (Effect)
import Foreign.Object (Object)
import JavaScript.Chrome.Shared.Event (Event, EventListener, toEventListener)
import JavaScript.Chrome.WebRequest.HttpHeaders (HttpHeaders)
import JavaScript.Chrome.WebRequest.RequestFilter (RequestFilter)
import JavaScript.Chrome.WebRequest.UploadData (UploadData)
import Literals (StringLit)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest

type ExtraInfoSpec = Array (StringLit "blocking" |+| StringLit "requestHeaders" |+| StringLit "requestBody")

foreign import _addListener :: forall source listener. EventListener source listener -> RequestFilter -> ExtraInfoSpec -> Event source listener -> Effect Unit

addListener :: forall source listener filter
    .  Castable filter RequestFilter
    => EventListener source listener -> filter -> ExtraInfoSpec -> Event source listener -> Effect Unit
addListener listener filter extraInfo event = _addListener listener (cast filter) (extraInfo) event

addListener' :: forall source listener filter
    .  Castable filter RequestFilter
    => listener -> filter -> ExtraInfoSpec -> Event source listener -> Effect Unit
addListener' listener filter extraInfo event = addListener (toEventListener listener) filter extraInfo event

type OnBeforeSendHeadersDetails =
    { url :: String
    , method :: String
    , frameId :: Int
    , requestHeaders :: Nullable HttpHeaders
    }

foreign import onBeforeSendHeaders :: Event "webRequest.onBeforeSendHeaders" (OnBeforeSendHeadersDetails -> Effect Unit)

type OnBeforeRequestDetails =
    { url :: String
    , method :: String
    , frameId :: Int
    , requestBody :: Nullable
        { error :: Nullable String
        , formData :: Nullable (Object (Array String))
        , raw :: Nullable (Array UploadData)
        }
    }

foreign import onBeforeRequest :: Event "webRequest.onBeforeRequest" (OnBeforeRequestDetails -> Effect Unit)

type OnCompletedDetails =
    { url :: String
    , method :: String
    , frameId :: Int
    , tabId :: Int
    }

foreign import onCompleted :: Event "webRequest.onCompleted" (OnCompletedDetails -> Effect Unit)
