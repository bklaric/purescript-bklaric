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
    , concat
    , concat_
    , toString
    , toString_
    , toString__
    , toString___
    ) where

import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
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

foreign import allocImpl :: Int -> Foreign -> Encoding -> Effect Buffer

alloc :: Int -> Effect Buffer
alloc size = allocImpl size undefined undefined

allocBuffer :: Int -> Buffer -> Effect Buffer
allocBuffer size fill = allocImpl size (unsafeToForeign fill) undefined

allocInteger :: Int -> Int -> Effect Buffer
allocInteger size fill = allocImpl size (unsafeToForeign fill) undefined

allocString :: Int -> String -> Encoding -> Effect Buffer
allocString size fill encoding = allocImpl size (unsafeToForeign fill) encoding

allocString_ :: Int -> String -> Effect Buffer
allocString_ size fill = allocImpl size (unsafeToForeign fill) undefined

foreign import fromStringImpl :: String -> Encoding -> Effect Buffer

fromString :: String -> Encoding -> Effect Buffer
fromString string encoding = fromStringImpl string encoding

fromString_ :: String -> Effect Buffer
fromString_ string = fromStringImpl string undefined

foreign import concat :: Array Buffer -> Int -> Effect Buffer

concat_ :: Array Buffer -> Effect Buffer
concat_ buffers = concat buffers undefined

foreign import toStringImpl :: Encoding -> Int -> Int -> Buffer -> Effect String

toString :: Encoding -> Int -> Int -> Buffer -> Effect String
toString encoding start end buffer = toStringImpl encoding start end buffer

toString_ :: Encoding -> Int -> Buffer -> Effect String
toString_ encoding start buffer = toStringImpl encoding start undefined buffer

toString__ :: Encoding -> Buffer -> Effect String
toString__ encoding buffer = toStringImpl encoding undefined undefined buffer

toString___ :: Buffer -> Effect String
toString___ buffer = toStringImpl undefined undefined undefined buffer
