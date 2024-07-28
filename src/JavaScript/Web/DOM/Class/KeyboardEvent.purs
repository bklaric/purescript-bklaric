module JavaScript.Web.DOM.Class.KeyboardEvent where

import JavaScript.Web.DOM.Class.UiEvent (class UiEvent)

class UiEvent keyboardEvent <= KeyboardEvent keyboardEvent where
    key :: keyboardEvent -> String
    code :: keyboardEvent -> String
    altKey :: keyboardEvent -> Boolean
    ctrlKey :: keyboardEvent -> Boolean
    shiftKey :: keyboardEvent -> Boolean
    metaKey :: keyboardEvent -> Boolean
    getModifierState :: String -> keyboardEvent -> Boolean

foreign import keyDefault :: forall keyboardEvent. keyboardEvent -> String
foreign import codeDefault :: forall keyboardEvent. keyboardEvent -> String
foreign import altKeyDefault :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import ctrlKeyDefault :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import shiftKeyDefault :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import metaKeyDefault :: forall keyboardEvent. keyboardEvent -> Boolean
foreign import getModifierStateDefault :: forall keyboardEvent. String -> keyboardEvent -> Boolean
