module JavaScript.Error (Error, new, name, message, stack, cause, readError) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Foreign (Foreign)
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

foreign import _cause :: forall error. error -> Nullable Foreign

-- | The value an error carries as its `cause`, if any. Load-bearing for the
-- | global `fetch`, which rejects with a bare "fetch failed" TypeError and puts
-- | the actual transport failure in here -- read only the message and every
-- | network problem looks alike. A cause need not be an Error, so a caller after
-- | a description should go through `readError`.
cause :: forall error. Error error => error -> Maybe Foreign
cause = _cause >>> toMaybe
