module JavaScript.Chrome.Downloads where

import Prelude

import JavaScript.Chrome.Downloads.DangerType (DangerType)
import JavaScript.Chrome.Downloads.DownloadItem (DownloadItem)
import JavaScript.Chrome.Downloads.FilenameConflictAction (FilenameConflictAction)
import JavaScript.Chrome.Downloads.InterruptReason (InterruptReason)
import JavaScript.Chrome.Downloads.State (State)
import JavaScript.Chrome.Shared.Event (Event)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/downloads

type DownloadOptions =
    { url :: String
    , filename :: UndefinedOr String
    , conflictAction :: UndefinedOr FilenameConflictAction
    , saveAs :: UndefinedOr Boolean
    , method :: UndefinedOr String
    , headers :: UndefinedOr (Array {name :: String, value :: String})
    , body :: UndefinedOr String
    }

type DownloadQuery =
    { id :: UndefinedOr Int
    , url :: UndefinedOr String
    , filename :: UndefinedOr String
    , danger :: UndefinedOr DangerType
    , mime :: UndefinedOr String
    , startTime :: UndefinedOr String
    , endTime :: UndefinedOr String
    , state :: UndefinedOr State
    , paused :: UndefinedOr Boolean
    , error :: UndefinedOr InterruptReason
    , bytesReceived :: UndefinedOr Number
    , totalBytes :: UndefinedOr Number
    , fileSize :: UndefinedOr Number
    , exists :: UndefinedOr Boolean
    , orderBy :: UndefinedOr (Array String)
    , limit :: UndefinedOr Int
    }

type GetFileIconOptions =
    { size :: UndefinedOr Int
    }

-- Functions

foreign import _download :: DownloadOptions -> Promise Error Int

download :: forall options. Castable options DownloadOptions =>
    options -> Promise Error Int
download options = _download (cast options)

download' :: String -> Promise Error Int
download' url = download {url}

foreign import _search :: DownloadQuery -> Promise Error (Array DownloadItem)

search :: forall query. Castable query DownloadQuery =>
    query -> Promise Error (Array DownloadItem)
search query = _search (cast query)

search_ :: Promise Error (Array DownloadItem)
search_ = search {}

foreign import pause :: Int -> Promise Error Unit

foreign import resume :: Int -> Promise Error Unit

foreign import cancel :: Int -> Promise Error Unit

foreign import _getFileIcon :: Int -> GetFileIconOptions -> Promise Error (Nullable String)

getFileIcon :: forall options. Castable options GetFileIconOptions =>
    Int -> options -> Promise Error (Maybe String)
getFileIcon downloadId options =
    _getFileIcon downloadId (cast options)
    <#> toMaybe

getFileIcon_ :: Int -> Promise Error (Maybe String)
getFileIcon_ downloadId = getFileIcon downloadId {}

foreign import open :: Int -> Promise Error Unit

foreign import show :: Int -> Promise Error Unit

foreign import showDefaultFolder :: Promise Error Unit

foreign import _erase :: DownloadQuery -> Promise Error (Array Int)

erase :: forall query. Castable query DownloadQuery =>
    query -> Promise Error (Array Int)
erase query = _erase (cast query)

erase_ :: Promise Error (Array Int)
erase_ = erase {}

foreign import removeFile :: Int -> Promise Error Unit

foreign import acceptDanger :: Int -> Promise Error Unit

foreign import setShelfEnabled :: Boolean -> Promise Error Unit

-- Events

foreign import onCreated :: Event "downloads.onCreated" (DownloadItem -> Effect Unit)

foreign import onErased :: Event "downloads.onErased" (Int -> Effect Unit)

type DownloadDelta =
    { id :: Int
    , url :: UndefinedOr {previous :: UndefinedOr String, current :: UndefinedOr String}
    , finalUrl :: UndefinedOr {previous :: UndefinedOr String, current :: UndefinedOr String}
    , filename :: UndefinedOr {previous :: UndefinedOr String, current :: UndefinedOr String}
    , danger :: UndefinedOr {previous :: UndefinedOr DangerType, current :: UndefinedOr DangerType}
    , mime :: UndefinedOr {previous :: UndefinedOr String, current :: UndefinedOr String}
    , startTime :: UndefinedOr {previous :: UndefinedOr String, current :: UndefinedOr String}
    , endTime :: UndefinedOr {previous :: UndefinedOr String, current :: UndefinedOr String}
    , state :: UndefinedOr {previous :: UndefinedOr State, current :: UndefinedOr State}
    , paused :: UndefinedOr {previous :: UndefinedOr Boolean, current :: UndefinedOr Boolean}
    , canResume :: UndefinedOr {previous :: UndefinedOr Boolean, current :: UndefinedOr Boolean}
    , error :: UndefinedOr {previous :: UndefinedOr InterruptReason, current :: UndefinedOr InterruptReason}
    , totalBytes :: UndefinedOr {previous :: UndefinedOr Number, current :: UndefinedOr Number}
    , fileSize :: UndefinedOr {previous :: UndefinedOr Number, current :: UndefinedOr Number}
    , exists :: UndefinedOr {previous :: UndefinedOr Boolean, current :: UndefinedOr Boolean}
    }

foreign import onChanged :: Event "downloads.onChanged" (DownloadDelta -> Effect Unit)
