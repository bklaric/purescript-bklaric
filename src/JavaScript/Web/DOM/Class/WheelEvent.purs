module JavaScript.DOM.Class.WheelEvent where

import JavaScript.DOM.Class.MouseEvent (class MouseEvent)

class MouseEvent event <= WheelEvent event where
    deltaX :: event -> Number
    deltaY :: event -> Number
    deltaZ :: event -> Number

foreign import deltaXDefault :: forall event. event -> Number
foreign import deltaYDefault :: forall event. event -> Number
foreign import deltaZDefault :: forall event. event -> Number
