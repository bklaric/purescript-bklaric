module JavaScript.Web.DOM.Class.ErrorEvent where

import JavaScript.Web.DOM.Class (class Event)
import JavaScript.Error (Error)

class Event event <= ErrorEvent event where
    message :: event -> String
    filename :: event -> String
    lineno :: event -> Int
    colno :: event -> Int
    error :: event -> Error

foreign import messageDefault :: forall event. event -> String
foreign import filenameDefault :: forall event. event -> String
foreign import linenoDefault :: forall event. event -> Int
foreign import colnoDefault :: forall event. event -> Int
foreign import errorDefault :: forall event. event -> Error
