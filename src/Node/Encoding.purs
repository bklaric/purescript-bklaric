module Node.Encoding
    ( Encoding (..)
    , toNodeString
    ) where

import Prelude

data Encoding
    = ASCII
    | UTF8
    | UTF16LE
    | UCS2
    | Base64
    | Latin1
    | Binary
    | Hex

instance Show Encoding where
    show ASCII   = "ASCII"
    show UTF8    = "UTF8"
    show UTF16LE = "UTF16LE"
    show UCS2    = "UCS2"
    show Base64  = "Base64"
    show Latin1  = "Latin1"
    show Binary  = "Binary"
    show Hex     = "Hex"

toNodeString :: Encoding -> String
toNodeString ASCII   = "ascii"
toNodeString UTF8    = "utf8"
toNodeString UTF16LE = "utf16le"
toNodeString UCS2    = "ucs2"
toNodeString Base64  = "base64"
toNodeString Latin1  = "latin1"
toNodeString Binary  = "binary"
toNodeString Hex     = "hex"
