module JavaScript.DOM.Events.ErrorEvent where

import JavaScript.DOM.Class.ErrorEvent (class ErrorEvent, colnoDefault, errorDefault, filenameDefault, linenoDefault, messageDefault)
import JavaScript.DOM.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)
import JavaScript.DOM.Events.EventType (EventType(..))

foreign import data ErrorEvent :: Type

instance eventErrorEvent :: Event ErrorEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault

instance mouseEventErrorEvent :: ErrorEvent ErrorEvent where
    message = messageDefault
    filename = filenameDefault
    lineno = linenoDefault
    colno = colnoDefault
    error = errorDefault

error :: EventType ErrorEvent
error = EventType "error"
