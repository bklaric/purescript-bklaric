module JavaScript.Chrome.WebRequest (addListener, addListener', OnBeforeSendHeadersDetails, onBeforeSendHeaders) where

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

addListener :: forall source listener filter extraInfo
    .  Castable filter RequestFilter
    => Castable extraInfo ExtraInfoSpec
    => EventListener source listener -> filter -> extraInfo -> Event source listener -> Effect Unit
addListener listener filter extraInfo event = _addListener listener (cast filter) (cast extraInfo) event

addListener' :: forall source listener filter extraInfo
    .  Castable filter RequestFilter
    => Castable extraInfo ExtraInfoSpec
    => listener -> filter -> extraInfo -> Event source listener -> Effect Unit
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
