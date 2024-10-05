module JavaScript.Chrome.WebRequest.OnHeadersReceived where

import Prelude

import JavaScript.Chrome.WebRequest.HttpHeaders (HttpHeaders)
import JavaScript.Chrome.WebRequest.RequestFilter (RequestFilter)
import Data.Maybe (Maybe, fromJust)
import Effect (Effect)
import Foreign (Foreign)
import Literals (StringLit)
import Partial.Unsafe (unsafePartial)
import Untagged.Union (type (|+|))
import Yoga.JSON (read_, write)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/onHeadersReceived

type OnHeadersReceivedDetails =
    { tabId :: Int
    , statusCode :: Int
    , url :: String
    , responseHeaders :: Maybe HttpHeaders
    }

foreign import onHeadersReceivedAddListenerImpl ::
    (Foreign -> Effect Unit) -> Foreign -> Array (StringLit "blocking" |+| StringLit "responseHeaders") -> Effect Unit

onHeadersReceivedAddListener :: (OnHeadersReceivedDetails -> Effect Unit) -> RequestFilter -> Array (StringLit "blocking" |+| StringLit "responseHeaders") -> Effect Unit
onHeadersReceivedAddListener callback filter extraInfoSpec =
    onHeadersReceivedAddListenerImpl
    (\details -> read_ details # unsafePartial fromJust # callback)
    (write filter)
    extraInfoSpec
