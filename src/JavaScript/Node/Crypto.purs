module JavaScript.Node.Crypto
    ( randomBytes
    , randomBytesSync
    , Cipher
    , Decipher
    , class Ciphering
    , CipherOptions
    , createCipheriv
    , createCipheriv_
    , createDecipheriv
    , createDecipheriv_
    , updateBuffer
    , updateString
    , final
    , getAuthTag
    , setAuthTag
    ) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import JavaScript.Node.Buffer (Buffer, Encoding)
import JavaScript.Node.Errors (Error)
import Undefined (undefined)

foreign import _randomBytes
    :: Int
    -> (Error -> Effect Unit)
    -> (Buffer -> Effect Unit)
    -> Effect Unit

randomBytes :: Int -> (Either Error Buffer -> Effect Unit) -> Effect Unit
randomBytes size callback =
    _randomBytes size (Left >>> callback) (Right >>> callback)

foreign import _randomBytesSync
    :: Int
    -> (Error -> Either Error Buffer)
    -> (Buffer -> Either Error Buffer)
    -> Effect (Either Error Buffer)

randomBytesSync :: Int -> Effect (Either Error Buffer)
randomBytesSync size = _randomBytesSync size Left Right

foreign import data Cipher :: Type

foreign import data Decipher :: Type

-- | What a Cipher and a Decipher have in common: both are fed data with
-- | `updateBuffer`/`updateString` and closed with `final`.
class Ciphering (cipher :: Type)

instance Ciphering Cipher

instance Ciphering Decipher

-- | `authTagLength` is required by the modes that authenticate (GCM, CCM, OCB)
-- | and ignored by the rest.
type CipherOptions = { authTagLength :: Int }

-- Every operation below throws rather than returning an error -- a wrong key
-- length, a tag that doesn't verify -- so each is wrapped into an Either the way
-- randomBytesSync is, and a caller never has to guard a JS exception by hand.

foreign import _createCipheriv
    :: String
    -> Buffer
    -> Buffer
    -> CipherOptions
    -> (Error -> Either Error Cipher)
    -> (Cipher -> Either Error Cipher)
    -> Effect (Either Error Cipher)

createCipheriv ::
    String -> Buffer -> Buffer -> CipherOptions -> Effect (Either Error Cipher)
createCipheriv algorithm key iv options =
    _createCipheriv algorithm key iv options Left Right

createCipheriv_ :: String -> Buffer -> Buffer -> Effect (Either Error Cipher)
createCipheriv_ algorithm key iv =
    _createCipheriv algorithm key iv undefined Left Right

foreign import _createDecipheriv
    :: String
    -> Buffer
    -> Buffer
    -> CipherOptions
    -> (Error -> Either Error Decipher)
    -> (Decipher -> Either Error Decipher)
    -> Effect (Either Error Decipher)

createDecipheriv ::
    String -> Buffer -> Buffer -> CipherOptions -> Effect (Either Error Decipher)
createDecipheriv algorithm key iv options =
    _createDecipheriv algorithm key iv options Left Right

createDecipheriv_ :: String -> Buffer -> Buffer -> Effect (Either Error Decipher)
createDecipheriv_ algorithm key iv =
    _createDecipheriv algorithm key iv undefined Left Right

foreign import _update
    :: forall data_ cipher
    .  data_
    -> Encoding
    -> cipher
    -> (Error -> Either Error Buffer)
    -> (Buffer -> Either Error Buffer)
    -> Effect (Either Error Buffer)

updateBuffer :: forall cipher. Ciphering cipher =>
    Buffer -> cipher -> Effect (Either Error Buffer)
updateBuffer data_ cipher = _update data_ undefined cipher Left Right

updateString :: forall cipher. Ciphering cipher =>
    String -> Encoding -> cipher -> Effect (Either Error Buffer)
updateString data_ encoding cipher = _update data_ encoding cipher Left Right

foreign import _final
    :: forall cipher
    .  cipher
    -> (Error -> Either Error Buffer)
    -> (Buffer -> Either Error Buffer)
    -> Effect (Either Error Buffer)

final :: forall cipher. Ciphering cipher => cipher -> Effect (Either Error Buffer)
final cipher = _final cipher Left Right

foreign import _getAuthTag
    :: Cipher
    -> (Error -> Either Error Buffer)
    -> (Buffer -> Either Error Buffer)
    -> Effect (Either Error Buffer)

-- | Only valid once `final` has run: the tag authenticates the whole ciphertext.
getAuthTag :: Cipher -> Effect (Either Error Buffer)
getAuthTag cipher = _getAuthTag cipher Left Right

foreign import _setAuthTag
    :: Buffer
    -> Decipher
    -> (Error -> Either Error Unit)
    -> (Unit -> Either Error Unit)
    -> Effect (Either Error Unit)

-- | Must be set before `final`, which is where a tag that doesn't verify throws.
setAuthTag :: Buffer -> Decipher -> Effect (Either Error Unit)
setAuthTag authTag decipher = _setAuthTag authTag decipher Left Right
