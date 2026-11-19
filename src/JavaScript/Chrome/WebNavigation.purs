module JavaScript.Chrome.WebNavigation (OnBeforeNavigateDetails, onBeforeNavigate, OnCommittedDetails, onCommitted, OnCompletedDetails, onCompleted, OnHistoryStateUpdatedDetails, onHistoryStateUpdated) where

import Prelude

import Effect (Effect)
import JavaScript.Chrome.Shared.Event (Event)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webNavigation

type OnBeforeNavigateDetails =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , parentFrameId :: Int
    , timeStamp :: Number
    }

foreign import onBeforeNavigate :: Event "webNavigation.onBeforeNavigate" (OnBeforeNavigateDetails -> Effect Unit)

type OnCommittedDetails =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , parentFrameId :: Int
    , timeStamp :: Number
    , transitionType :: String
    , transitionQualifiers :: Array String
    }

foreign import onCommitted :: Event "webNavigation.onCommitted" (OnCommittedDetails -> Effect Unit)

type OnCompletedDetails =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , timeStamp :: Number
    }

foreign import onCompleted :: Event "webNavigation.onCompleted" (OnCompletedDetails -> Effect Unit)

type OnHistoryStateUpdatedDetails =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , timeStamp :: Number
    }

foreign import onHistoryStateUpdated :: Event "webNavigation.onHistoryStateUpdated" (OnHistoryStateUpdatedDetails -> Effect Unit)
