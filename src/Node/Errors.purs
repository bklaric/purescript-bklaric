module Node.Errors where

import Prelude

import Effect (Effect)
import Error.Class (class Error, defaultMessage, defaultName, defaultStack)
import Node.Errors.Class (class NodeError, defaultCode)

foreign import data Error :: Type

instance Error Error where
    name = defaultName
    message = defaultMessage
    stack = defaultStack

instance NodeError Error where
    code = defaultCode

foreign import stackTraceLimit :: Effect Int

foreign import setStackTraceLimit :: Int -> Effect Unit
