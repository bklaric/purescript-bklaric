module Node.Buffer
    ( Buffer
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

import Foreign (Foreign, unsafeToForeign)
import Effect (Effect)
import Node.Encoding (Encoding, toNodeString)
import Undefined (undefined)

foreign import data Buffer :: Type

foreign import allocImpl :: Int -> Foreign -> String -> Effect Buffer

alloc :: Int -> Effect Buffer
alloc size = allocImpl size undefined undefined

allocBuffer :: Int -> Buffer -> Effect Buffer
allocBuffer size fill = allocImpl size (unsafeToForeign fill) undefined

allocInteger :: Int -> Int -> Effect Buffer
allocInteger size fill = allocImpl size (unsafeToForeign fill) undefined

allocString :: Int -> String -> Encoding -> Effect Buffer
allocString size fill encoding =
    allocImpl size (unsafeToForeign fill) (toNodeString encoding)

allocString_ :: Int -> String -> Effect Buffer
allocString_ size fill = allocImpl size (unsafeToForeign fill) undefined

foreign import fromStringImpl :: String -> String -> Effect Buffer

fromString :: String -> Encoding -> Effect Buffer
fromString string encoding = fromStringImpl string (toNodeString encoding)

fromString_ :: String -> Effect Buffer
fromString_ string = fromStringImpl string undefined

foreign import concat :: Array Buffer -> Int -> Effect Buffer

concat_ :: Array Buffer -> Effect Buffer
concat_ buffers = concat buffers undefined

foreign import toStringImpl :: String -> Int -> Int -> Buffer -> Effect String

toString :: Encoding -> Int -> Int -> Buffer -> Effect String
toString encoding start end buffer =
    toStringImpl (toNodeString encoding) start end buffer

toString_ :: Encoding -> Int -> Buffer -> Effect String
toString_ encoding start buffer =
    toStringImpl (toNodeString encoding) start undefined buffer

toString__ :: Encoding -> Buffer -> Effect String
toString__ encoding buffer =
    toStringImpl (toNodeString encoding) undefined undefined buffer

toString___ :: Buffer -> Effect String
toString___ buffer = toStringImpl undefined undefined undefined buffer
