module JavaScript.Error (Error, new, name, message, stack) where

import JavaScript.Class (class Error)

foreign import data Error :: Type

instance Error Error

foreign import new :: String -> Error

foreign import _name :: forall error. error -> String

name :: forall error. Error error => error -> String
name = _name

foreign import _message :: forall error. error -> String

message :: forall error. Error error => error -> String
message = _message

foreign import _stack :: forall error. error -> String

stack :: forall error. Error error => error -> String
stack = _stack
