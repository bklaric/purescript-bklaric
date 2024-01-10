module Node.Errors where

import Prelude

import Effect (Effect)
import Error.Class (class Error, defaultMessage, defaultName)
import Node.Errors.Class (class NodeError, defaultCode, defaultStack)

foreign import data Error :: Type

instance Error Error where
    name = defaultName
    message = defaultMessage

instance NodeError Error where
    code = defaultCode
    stack = defaultStack

foreign import stackTraceLimit :: Effect Int

foreign import setStackTraceLimit :: Int -> Effect Unit
