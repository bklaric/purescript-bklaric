module Bcrypt
    ( genSalt
    , genSalt_
    , genSalt__
    , hash
    , hash'
    , hash_
    , compare
    , getRounds
    ) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Foreign (Foreign)
import JavaScript.Node.Errors (Error)
import Undefined (undefined)
import Unsafe.Coerce (unsafeCoerce)

foreign import _genSalt
    :: Int
    -> Char
    -> (Error -> Effect Unit)
    -> (String -> Effect Unit)
    -> Effect Unit

genSalt :: Int -> Char -> (Either Error String -> Effect Unit) -> Effect Unit
genSalt rounds minor callback =
    _genSalt rounds minor (Left >>> callback) (Right >>> callback)

genSalt_ :: Int -> (Either Error String -> Effect Unit) -> Effect Unit
genSalt_ rounds = genSalt rounds undefined

genSalt__ :: (Either Error String -> Effect Unit) -> Effect Unit
genSalt__ = genSalt_ undefined

foreign import _hash
    :: String
    -> Foreign
    -> (Error -> Effect Unit)
    -> (String -> Effect Unit)
    -> Effect Unit

hash :: String -> String -> (Either Error String -> Effect Unit) -> Effect Unit
hash data' salt callback =
    _hash data' (unsafeCoerce salt) (Left >>> callback) (Right >>> callback)

hash' :: String -> Int -> (Either Error String -> Effect Unit) -> Effect Unit
hash' data' rounds callback =
    _hash
        data' (unsafeCoerce rounds) (Left >>> callback) (Right >>> callback)

hash_ :: String -> (Either Error String -> Effect Unit) -> Effect Unit
hash_ data' callback = genSalt__ case _ of
    Left error -> callback $ Left error
    Right salt -> hash data' salt callback

foreign import _compare
    :: String
    -> String
    -> (Error -> Effect Unit)
    -> (Boolean -> Effect Unit)
    -> Effect Unit

compare
    :: String -> String -> (Either Error Boolean -> Effect Unit) -> Effect Unit
compare data' encrypted callback =
    _compare data' encrypted (Left >>> callback) (Right >>> callback)

foreign import getRounds :: String -> Int
