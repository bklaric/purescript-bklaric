module JavaScript.Web.DOM.Events.MessageEvent (MessageEvent, data_, message, messageerror) where

import Foreign (Foreign)
import JavaScript.Web.DOM.Class (class Event, class MessageEvent)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data MessageEvent :: Type

instance Event MessageEvent

instance MessageEvent MessageEvent

foreign import _data :: forall messageEvent. messageEvent -> Foreign

data_ :: forall messageEvent. MessageEvent messageEvent => messageEvent -> Foreign
data_ = _data

message :: EventType MessageEvent
message = EventType "message"

messageerror :: EventType MessageEvent
messageerror = EventType "messageerror"
