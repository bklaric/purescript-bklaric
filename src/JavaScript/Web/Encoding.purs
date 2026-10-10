module JavaScript.Web.Encoding (encodeUtf8, decodeBase64) where

import Data.Either (Either(..))
import JavaScript.ArrayBuffer (ArrayBuffer)
import JavaScript.Error (Error)

-- https://developer.mozilla.org/en-US/docs/Web/API/TextEncoder
-- https://developer.mozilla.org/en-US/docs/Web/API/Window/atob

-- Pure: the bytes depend only on the string, and encoding cannot fail.
foreign import encodeUtf8 :: String -> ArrayBuffer

foreign import _decodeBase64 :: (Error -> Either Error ArrayBuffer) -> (ArrayBuffer -> Either Error ArrayBuffer) -> String -> Either Error ArrayBuffer

-- | Decodes standard (not URL-safe) base64. Pure for the same reason as `encodeUtf8`; the error for
-- | invalid input is returned rather than thrown.
decodeBase64 :: String -> Either Error ArrayBuffer
decodeBase64 = _decodeBase64 Left Right
