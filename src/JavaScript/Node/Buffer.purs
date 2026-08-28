module JavaScript.Node.Buffer
    ( Buffer
    , Encoding
    , alloc
    , allocBuffer
    , allocInteger
    , allocString
    , allocString_
    , fromString
    , fromString_
    , fromArrayBuffer
    , concat
    , concat_
    , length
    , subarray
    , toString
    , toString_
    , toString__
    , toString___
    ) where

import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
import JavaScript.ArrayBuffer (ArrayBuffer)
import Literals (StringLit)
import Undefined (undefined)
import Untagged.Union (type (|+|))

foreign import data Buffer :: Type

type Encoding
    =   StringLit "ascii"
    |+| StringLit "utf8"
    |+| StringLit "utf-8"
    |+| StringLit "utf16le"
    |+| StringLit "utf-16le"
    |+| StringLit "ucs2"
    |+| StringLit "ucs-2"
    |+| StringLit "base64"
    |+| StringLit "base64url"
    |+| StringLit "latin1"
    |+| StringLit "binary"
    |+| StringLit "hex"

foreign import _alloc :: Int -> Foreign -> Encoding -> Effect Buffer

alloc :: Int -> Effect Buffer
alloc size = _alloc size undefined undefined

allocBuffer :: Int -> Buffer -> Effect Buffer
allocBuffer size fill = _alloc size (unsafeToForeign fill) undefined

allocInteger :: Int -> Int -> Effect Buffer
allocInteger size fill = _alloc size (unsafeToForeign fill) undefined

allocString :: Int -> String -> Encoding -> Effect Buffer
allocString size fill encoding = _alloc size (unsafeToForeign fill) encoding

allocString_ :: Int -> String -> Effect Buffer
allocString_ size fill = _alloc size (unsafeToForeign fill) undefined

foreign import _fromString :: String -> Encoding -> Effect Buffer

fromString :: String -> Encoding -> Effect Buffer
fromString string encoding = _fromString string encoding

fromString_ :: String -> Effect Buffer
fromString_ string = _fromString string undefined

-- Wrap an ArrayBuffer in a Buffer sharing the same memory (no copy).
foreign import fromArrayBuffer :: ArrayBuffer -> Effect Buffer

foreign import concat :: Array Buffer -> Int -> Effect Buffer

concat_ :: Array Buffer -> Effect Buffer
concat_ buffers = concat buffers undefined

foreign import _toString :: Encoding -> Int -> Int -> Buffer -> Effect String

toString :: Encoding -> Int -> Int -> Buffer -> Effect String
toString encoding start end buffer = _toString encoding start end buffer

toString_ :: Encoding -> Int -> Buffer -> Effect String
toString_ encoding start buffer = _toString encoding start undefined buffer

toString__ :: Encoding -> Buffer -> Effect String
toString__ encoding buffer = _toString encoding undefined undefined buffer

toString___ :: Buffer -> Effect String
toString___ buffer = _toString undefined undefined undefined buffer

-- | How many bytes the buffer holds.
foreign import length :: Buffer -> Effect Int

-- | A view over part of the buffer, sharing its memory rather than copying.
foreign import subarray :: Int -> Int -> Buffer -> Effect Buffer
