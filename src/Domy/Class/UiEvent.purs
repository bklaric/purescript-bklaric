module Domy.Class.UiEvent where

import Domy.Class.Event (class Event)

class Event event <= UiEvent event where
    detail :: event -> Number

foreign import detailDefault :: forall event. event -> Number
