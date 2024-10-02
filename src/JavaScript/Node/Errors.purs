module JavaScript.Node.Errors where

import Prelude

import Effect (Effect)
import JavaScript.Class (class Error)
import JavaScript.Node.Errors.Class (class NodeError, defaultCode)

foreign import data Error :: Type

instance Error Error

instance NodeError Error where
    code = defaultCode

foreign import stackTraceLimit :: Effect Int

foreign import setStackTraceLimit :: Int -> Effect Unit
