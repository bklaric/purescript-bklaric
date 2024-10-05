module JavaScript.Chrome.WebRequest.RequestFilter where

import JavaScript.Chrome.WebRequest.ResourceType (ResourceType)
import Data.Maybe (Maybe)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/RequestFilter

type RequestFilter =
    { urls :: Array String
    , types :: Maybe (Array ResourceType)
    , tabId :: Maybe Int
    , windowId :: Maybe Int
    -- , incognito :: Maybe Boolean -- Chrome throws [Error at parameter 'filter': Unexpected property: 'incognito'.]
    }
