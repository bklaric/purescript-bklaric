module Domy.Events.UiEvent where

import Domy.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)

foreign import data MouseEvent :: Type

instance eventMouseEvent :: Event MouseEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault
