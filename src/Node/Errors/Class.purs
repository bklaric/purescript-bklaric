module Node.Errors.Class where

import Error.Class (class Error)

class Error error <= NodeError error where
    code :: error -> String
    stack :: error -> String

foreign import defaultCode :: forall error. error -> String

foreign import defaultStack :: forall error. error -> String
