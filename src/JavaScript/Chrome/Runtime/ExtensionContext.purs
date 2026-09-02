module JavaScript.Chrome.Runtime.ExtensionContext (ExtensionContext) where

import Data.Nullable (Nullable)

-- https://developer.chrome.com/docs/extensions/reference/api/runtime#type-ExtensionContext

-- A plain object rather than an opaque type: chrome.runtime.getContexts returns
-- structured-cloneable records. `tabId` and `windowId` are -1 when the context is
-- not in a tab.
type ExtensionContext =
    { contextId :: String
    , contextType :: String
    , documentId :: Nullable String
    , documentOrigin :: Nullable String
    , documentUrl :: Nullable String
    , frameId :: Int
    , incognito :: Boolean
    , tabId :: Int
    , windowId :: Int
    }
