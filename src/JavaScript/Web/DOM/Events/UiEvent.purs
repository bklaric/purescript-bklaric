module JavaScript.DOM.Events.UiEvent where

import JavaScript.DOM.Class.Event (class Event, preventDefaultDefault, stopImmediatePropagationDefault, stopPropagationDefault)

foreign import data MouseEvent :: Type

instance eventMouseEvent :: Event MouseEvent where
    preventDefault = preventDefaultDefault
    stopPropagation = stopPropagationDefault
    stopImmediatePropagation = stopImmediatePropagationDefault
