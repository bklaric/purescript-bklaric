module JavaScript.Chrome.WebRequest.HttpHeaders where

import Data.Maybe (Maybe)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/HttpHeaders

type HttpHeaders = Array
    { name :: String
    , value :: Maybe String
    , binaryValue :: Maybe (Array Int)
    }
