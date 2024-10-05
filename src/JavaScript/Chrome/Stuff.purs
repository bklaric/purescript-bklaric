module JavaScript.Chrome.Stuff where

import Prelude

import JavaScript.Chrome.Tabs.Tab (Tab)
import Effect (Effect)
import Undefined (undefined)

type RequestFilter =
    { tabId :: Int
    , types :: Array String
    , urls :: Array String
    , windowId :: Int
    }

type OnHeadersReceivedOptions = Array String

foreign import data OnHeadersReceivedDetails :: Type

foreign import tabId :: OnHeadersReceivedDetails -> Int

foreign import statusCode :: OnHeadersReceivedDetails -> Int

foreign import responseHeaders :: OnHeadersReceivedDetails -> Array { name :: String, value :: String }

foreign import url :: OnHeadersReceivedDetails -> String

foreign import addOnHeadersReceivedListener :: (OnHeadersReceivedDetails -> Effect Unit) -> RequestFilter -> OnHeadersReceivedOptions -> Effect Unit

foreign import executeScript :: forall a. a -> Effect Unit

foreign import insertCss :: forall a. a -> Effect Unit

foreign import sendMessageToTab :: forall props. Int -> Record props -> Effect Unit

foreign import getSessionObject :: forall props. Record props -> (Record props -> Effect Unit) -> Effect Unit

foreign import setSession :: forall props. Record props -> Effect Unit -> Effect Unit

foreign import getSyncObject :: forall props. Record props -> (Record props -> Effect Unit) -> Effect Unit

foreign import setSync :: forall props. Record props -> Effect Unit -> Effect Unit

foreign import getCurrentTab :: (Tab -> Effect Unit) -> Effect Unit

foreign import showContextMenuItem :: String -> Effect Unit

foreign import hideContextMenuItem :: String -> Effect Unit

foreign import addOnInstalledListener :: Effect Unit

foreign import data OnClickData :: Type

foreign import srcUrl :: OnClickData -> String

foreign import onContextMenuClick :: (OnClickData -> Tab -> Effect Unit) -> Effect Unit

foreign import wakeUp :: Effect Unit

setSession_ :: forall props. Record props -> Effect Unit
setSession_ record = setSession record undefined

setSync_ :: forall props. Record props -> Effect Unit
setSync_ record = setSync record undefined
