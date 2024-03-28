module JavaScript.Error where

import JavaScript.Error.Class (class Error, defaultMessage, defaultName, defaultStack)

foreign import data Error :: Type

instance errorError :: Error Error where
    name = defaultName
    message = defaultMessage
    stack = defaultStack

foreign import new :: String -> Error
