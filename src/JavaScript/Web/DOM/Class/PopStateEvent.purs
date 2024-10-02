module JavaScript.Web.DOM.Class.PopStateEvent where

import JavaScript.Web.DOM.Class (class Event)
import Foreign (Foreign)

class Event popStateEvent <= PopStateEvent popStateEvent where
    state :: popStateEvent -> Foreign

foreign import stateDefault :: forall popStateEvent. popStateEvent -> Foreign
