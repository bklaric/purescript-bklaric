module JavaScript.Node.Net
    ( isIP
    , isIPv4
    , isIPv6
    ) where

-- https://nodejs.org/api/net.html#netisipinput

-- 4 for an IPv4 address, 6 for an IPv6 address, 0 for anything else.
foreign import isIP :: String -> Int

foreign import isIPv4 :: String -> Boolean

foreign import isIPv6 :: String -> Boolean
