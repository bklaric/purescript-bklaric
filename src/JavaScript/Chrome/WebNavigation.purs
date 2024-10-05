module JavaScript.Chrome.WebNavigation where

import Prelude

import Effect (Effect)

foreign import data EventListener :: Type -> Type

foreign import toEventListener :: forall event. (event -> Effect Unit) -> Effect (EventListener event)

type OnBeforeNavigate =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , parentFrameId :: Int
    , timeStamp :: Number
    }

foreign import onBeforeNavigateAddListener :: EventListener OnBeforeNavigate -> Effect Unit

onBeforeNavigateAddListener' :: (OnBeforeNavigate -> Effect Unit) -> Effect Unit
onBeforeNavigateAddListener' listener = toEventListener listener >>= onBeforeNavigateAddListener

type OnCommitted =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , parentFrameId :: Int
    , timeStamp :: Number
    , transitionType :: String
    , transitionQualifiers :: Array String
    }

foreign import onCommittedAddListener :: EventListener OnCommitted -> Effect Unit

onCommittedAddListener' :: (OnCommitted -> Effect Unit) -> Effect Unit
onCommittedAddListener' listener = toEventListener listener >>= onCommittedAddListener

type OnCompleted =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , timeStamp :: Number
    }

foreign import onCompletedAddListener :: EventListener OnCompleted -> Effect Unit

onCompletedAddListener' :: (OnCompleted -> Effect Unit) -> Effect Unit
onCompletedAddListener' listener = toEventListener listener >>= onCompletedAddListener

type OnHistoryStateUpdated =
    { tabId :: Int
    , url :: String
    , frameId :: Int
    , timeStamp :: Number
    }

foreign import onHistoryStateUpdatedAddListener :: EventListener OnHistoryStateUpdated -> Effect Unit

onHistoryStateUpdatedAddListener' :: (OnHistoryStateUpdated -> Effect Unit) -> Effect Unit
onHistoryStateUpdatedAddListener' listener = toEventListener listener >>= onHistoryStateUpdatedAddListener
