module Domy.Class.PopStateEvent where

import Domy.Class.Event (class Event)
import Foreign (Foreign)

class Event popStateEvent <= PopStateEvent popStateEvent where
    state :: popStateEvent -> Foreign

foreign import stateDefault :: forall popStateEvent. popStateEvent -> Foreign
