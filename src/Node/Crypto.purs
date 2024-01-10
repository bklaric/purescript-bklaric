module Node.Crypto (randomBytes, randomBytesSync) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Node.Buffer (Buffer)
import Node.Errors (Error)

foreign import randomBytesImpl
    :: Int
    -> (Error -> Effect Unit)
    -> (Buffer -> Effect Unit)
    -> Effect Unit

randomBytes :: Int -> (Either Error Buffer -> Effect Unit) -> Effect Unit
randomBytes size callback =
    randomBytesImpl size (Left >>> callback) (Right >>> callback)

foreign import randomBytesSyncImpl
    :: Int
    -> (Error -> Either Error Buffer)
    -> (Buffer -> Either Error Buffer)
    -> Effect (Either Error Buffer)

randomBytesSync :: Int -> Effect (Either Error Buffer)
randomBytesSync size = randomBytesSyncImpl size Left Right
