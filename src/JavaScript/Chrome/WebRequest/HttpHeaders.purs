module JavaScript.Chrome.WebRequest.HttpHeaders where

import Data.Nullable (Nullable)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/HttpHeaders

type HttpHeaders = Array
    { name :: String
    , value :: Nullable String
    , binaryValue :: Nullable (Array Int)
    }
