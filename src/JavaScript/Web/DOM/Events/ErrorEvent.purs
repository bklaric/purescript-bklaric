module JavaScript.Web.DOM.Events.ErrorEvent (ErrorEvent, message, filename, lineno, colno, error', error) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Foreign (Foreign)
import JavaScript.Web.DOM.Class (class ErrorEvent, class Event)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data ErrorEvent :: Type

instance Event ErrorEvent
instance ErrorEvent ErrorEvent

foreign import _message :: forall event. event -> String
foreign import _filename :: forall event. event -> String
foreign import _lineno :: forall event. event -> Int
foreign import _colno :: forall event. event -> Int
foreign import _error :: forall event. event -> Nullable Foreign

message :: forall event. ErrorEvent event => event -> String
message = _message

filename :: forall event. ErrorEvent event => event -> String
filename = _filename

lineno :: forall event. ErrorEvent event => event -> Int
lineno = _lineno

colno :: forall event. ErrorEvent event => event -> Int
colno = _colno

error' :: forall event. ErrorEvent event => event -> Maybe Foreign
error' = _error >>> toMaybe

error :: EventType ErrorEvent
error = EventType "error"
