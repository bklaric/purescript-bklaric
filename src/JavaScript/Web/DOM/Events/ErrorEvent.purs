module JavaScript.Web.DOM.Events.ErrorEvent where

import JavaScript.Web.DOM.Class.ErrorEvent (class ErrorEvent, colnoDefault, errorDefault, filenameDefault, linenoDefault, messageDefault)
import JavaScript.Web.DOM.Class.Event (class Event)
import JavaScript.Web.DOM.Events.EventType (EventType(..))

foreign import data ErrorEvent :: Type

instance Event ErrorEvent

instance ErrorEvent ErrorEvent where
    message = messageDefault
    filename = filenameDefault
    lineno = linenoDefault
    colno = colnoDefault
    error = errorDefault

error :: EventType ErrorEvent
error = EventType "error"
