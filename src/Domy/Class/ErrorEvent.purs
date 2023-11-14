module Domy.Class.ErrorEvent where

import Domy.Class.Event (class Event)
import Foreign (Foreign)

class Event event <= ErrorEvent event where
    message :: event -> String
    filename :: event -> String
    lineno :: event -> Int
    colno :: event -> Int
    error :: event -> Foreign

foreign import messageDefault :: forall event. event -> String
foreign import filenameDefault :: forall event. event -> String
foreign import linenoDefault :: forall event. event -> Int
foreign import colnoDefault :: forall event. event -> Int
foreign import errorDefault :: forall event. event -> Foreign
