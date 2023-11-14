module Domy.Class.KeyboardEvent where

import Domy.Class.UiEvent (class UiEvent)

class UiEvent keyboardEvent <= KeyboardEvent keyboardEvent where
    key :: keyboardEvent -> String
    code :: keyboardEvent -> String

foreign import keyDefault :: forall keyboardEvent. keyboardEvent -> String
foreign import codeDefault :: forall keyboardEvent. keyboardEvent -> String
