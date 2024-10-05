module JavaScript.Chrome.WebRequest.OnResponseStarted(OnResponseStartedDetails, onResponseStartedAddListener) where

import Prelude

import JavaScript.Chrome.WebRequest.HttpHeaders (HttpHeaders)
import JavaScript.Chrome.WebRequest.RequestFilter (RequestFilter)
import Data.Maybe (Maybe, fromJust)
import Effect (Effect)
import Foreign (Foreign)
import Partial.Unsafe (unsafePartial)
import Yoga.JSON (read_, write)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/onResponseStarted

type OnResponseStartedDetails =
    { tabId :: Int
    , statusCode :: Int
    , url :: String
    , responseHeaders :: Maybe HttpHeaders
    }

foreign import onResponseStartedAddListenerImpl ::
    (Foreign -> Effect Unit) -> Foreign -> Array String -> Effect Unit

onResponseStartedAddListener :: (OnResponseStartedDetails -> Effect Unit) -> RequestFilter -> Array String -> Effect Unit
onResponseStartedAddListener callback filter extraInfoSpec =
    onResponseStartedAddListenerImpl
    (\details -> read_ details # unsafePartial fromJust # callback)
    (write filter)
    extraInfoSpec
