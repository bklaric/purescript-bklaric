module JavaScript.ArrayBuffer (ArrayBuffer, byteLength, takeBytes) where

-- https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/ArrayBuffer

foreign import data ArrayBuffer :: Type

foreign import byteLength :: ArrayBuffer -> Int

-- The first `n` bytes as unsigned integers (0-255), or fewer if the buffer is shorter. Reads a
-- short prefix without materialising the whole (possibly multi-megabyte) buffer as an array.
foreign import takeBytes :: Int -> ArrayBuffer -> Array Int
