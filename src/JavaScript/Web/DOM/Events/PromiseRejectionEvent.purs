module JavaScript.Web.DOM.Events.PromiseRejectionEvent (PromiseRejectionEvent, promise, reason, rejectionhandled, unhandledrejection) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Foreign (Foreign)
import JavaScript.Promise (Promise)
import JavaScript.Web.DOM.Class (class PromiseRejectionEvent, class Event)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data PromiseRejectionEvent :: Type

instance Event PromiseRejectionEvent
instance PromiseRejectionEvent PromiseRejectionEvent

foreign import _promise :: forall event. event -> Promise Foreign Foreign
foreign import _reason :: forall event. event -> Nullable Foreign

promise :: forall event. PromiseRejectionEvent event => event -> Promise Foreign Foreign
promise = _promise

reason :: forall event. PromiseRejectionEvent event => event -> Maybe Foreign
reason = _reason >>> toMaybe

rejectionhandled :: EventType PromiseRejectionEvent
rejectionhandled = EventType "rejectionhandled"

unhandledrejection :: EventType PromiseRejectionEvent
unhandledrejection = EventType "unhandledrejection"
