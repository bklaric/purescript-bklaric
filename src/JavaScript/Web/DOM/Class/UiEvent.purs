module JavaScript.DOM.Class.UiEvent where

import JavaScript.DOM.Class.Event (class Event)

class Event event <= UiEvent event where
    detail :: event -> Number

foreign import detailDefault :: forall event. event -> Number
