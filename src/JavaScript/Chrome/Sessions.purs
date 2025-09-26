module JavaScript.Chrome.Sessions (getRecentlyClosed, getRecentlyClosed_, restore) where

import JavaScript.Chrome.Sessions.Session (Session)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Literals.Undefined (undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/sessions

foreign import _getRecentlyClosed :: UndefinedOr {maxResults :: UndefinedOr Int} -> Promise Error (Array Session)

getRecentlyClosed :: forall filters. Castable filters (UndefinedOr {maxResults :: UndefinedOr Int}) =>
    filters -> Promise Error (Array Session)
getRecentlyClosed filters = _getRecentlyClosed (cast filters)

getRecentlyClosed_ :: Promise Error (Array Session)
getRecentlyClosed_ = getRecentlyClosed undefined

foreign import restore :: String -> Promise Error Session
