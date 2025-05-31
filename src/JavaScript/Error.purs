module JavaScript.Error (Error, new, name, message, stack, readError) where

import Data.Maybe (Maybe)
import JavaScript.Class (class Error)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data Error :: Type

instance Error Error

readError :: forall object. object -> Maybe Error
readError = unsafeReadProtoTagged "Error"

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
