module JavaScript.Chrome.WebRequest.RequestFilter where

import JavaScript.Chrome.WebRequest.ResourceType (ResourceType)
import Untagged.Union (UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/RequestFilter

type RequestFilter =
    { urls :: Array String
    , types :: UndefinedOr (Array ResourceType)
    , tabId :: UndefinedOr Int
    , windowId :: UndefinedOr Int
    -- , incognito :: UndefinedOr Boolean -- Chrome throws [Error at parameter 'filter': Unexpected property: 'incognito'.]
    }
