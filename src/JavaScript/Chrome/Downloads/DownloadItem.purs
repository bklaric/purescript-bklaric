module JavaScript.Chrome.Downloads.DownloadItem where

import Prelude

import JavaScript.Chrome.Downloads.DangerType (DangerType)
import JavaScript.Chrome.Downloads.InterruptReason (InterruptReason)
import JavaScript.Chrome.Downloads.State (State)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/downloads/DownloadItem

foreign import data DownloadItem :: Type

foreign import id :: DownloadItem -> Effect Int
foreign import url :: DownloadItem -> Effect String
foreign import finalUrl :: DownloadItem -> Effect String
foreign import referrer :: DownloadItem -> Effect String
foreign import filename :: DownloadItem -> Effect String
foreign import incognito :: DownloadItem -> Effect Boolean
foreign import danger :: DownloadItem -> Effect DangerType
foreign import mime :: DownloadItem -> Effect String
foreign import startTime :: DownloadItem -> Effect String
foreign import state :: DownloadItem -> Effect State
foreign import paused :: DownloadItem -> Effect Boolean
foreign import canResume :: DownloadItem -> Effect Boolean
foreign import bytesReceived :: DownloadItem -> Effect Number
foreign import totalBytes :: DownloadItem -> Effect Number
foreign import fileSize :: DownloadItem -> Effect Number
foreign import exists :: DownloadItem -> Effect Boolean

foreign import _endTime :: DownloadItem -> Effect (Nullable String)

endTime :: DownloadItem -> Effect (Maybe String)
endTime downloadItem = _endTime downloadItem <#> toMaybe

foreign import _estimatedEndTime :: DownloadItem -> Effect (Nullable String)

estimatedEndTime :: DownloadItem -> Effect (Maybe String)
estimatedEndTime downloadItem = _estimatedEndTime downloadItem <#> toMaybe

foreign import _error :: DownloadItem -> Effect (Nullable InterruptReason)

error :: DownloadItem -> Effect (Maybe InterruptReason)
error downloadItem = _error downloadItem <#> toMaybe
