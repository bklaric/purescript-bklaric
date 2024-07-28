module JavaScript.Web.DOM.Class.MouseEvent where

import JavaScript.Web.DOM.Class.UiEvent (class UiEvent)

class UiEvent mouseEvent <= MouseEvent mouseEvent where
    button :: mouseEvent -> Int
    buttons :: mouseEvent -> Int
    pageX :: mouseEvent -> Int
    pageY :: mouseEvent -> Int
    offsetX :: mouseEvent -> Int
    offsetY :: mouseEvent -> Int
    clientX :: mouseEvent -> Int
    clientY :: mouseEvent -> Int
    altKey :: mouseEvent -> Boolean
    ctrlKey :: mouseEvent -> Boolean
    shiftKey :: mouseEvent -> Boolean
    metaKey :: mouseEvent -> Boolean

foreign import buttonDefault :: forall mouseEvent. mouseEvent -> Int
foreign import buttonsDefault :: forall mouseEvent. mouseEvent -> Int
foreign import pageXDefault :: forall mouseEvent. mouseEvent -> Int
foreign import pageYDefault :: forall mouseEvent. mouseEvent -> Int
foreign import offsetXDefault :: forall mouseEvent. mouseEvent -> Int
foreign import offsetYDefault :: forall mouseEvent. mouseEvent -> Int
foreign import clientXDefault :: forall mouseEvent. mouseEvent -> Int
foreign import clientYDefault :: forall mouseEvent. mouseEvent -> Int
foreign import altKeyDefault :: forall mouseEvent. mouseEvent -> Boolean
foreign import ctrlKeyDefault :: forall mouseEvent. mouseEvent -> Boolean
foreign import shiftKeyDefault :: forall mouseEvent. mouseEvent -> Boolean
foreign import metaKeyDefault :: forall mouseEvent. mouseEvent -> Boolean
