module JavaScript.DOM.Class.Event where

import Effect (Effect)
import Prelude (Unit)

class Event event where
    preventDefault :: event -> Effect Unit
    stopPropagation :: event -> Effect Unit
    stopImmediatePropagation :: event -> Effect Unit

foreign import preventDefaultImpl :: forall event. event -> Effect Unit
foreign import stopPropagationImpl :: forall event. event -> Effect Unit
foreign import stopImmediatePropagationImpl :: forall event. event -> Effect Unit

-- Why can't I add class constraints to these default functions?
preventDefaultDefault :: forall event. event -> Effect Unit
preventDefaultDefault = preventDefaultImpl

stopPropagationDefault :: forall event. event -> Effect Unit
stopPropagationDefault = stopPropagationImpl

stopImmediatePropagationDefault :: forall event. event -> Effect Unit
stopImmediatePropagationDefault = stopImmediatePropagationImpl
