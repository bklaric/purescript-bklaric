module JavaScript.Chrome.Downloads.InterruptReason where

import Literals (StringLit)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/downloads/InterruptReason

type InterruptReason
    =   StringLit "FILE_FAILED"
    |+| StringLit "FILE_ACCESS_DENIED"
    |+| StringLit "FILE_NO_SPACE"
    |+| StringLit "FILE_NAME_TOO_LONG"
    |+| StringLit "FILE_TOO_LARGE"
    |+| StringLit "FILE_VIRUS_INFECTED"
    |+| StringLit "FILE_TRANSIENT_ERROR"
    |+| StringLit "FILE_BLOCKED"
    |+| StringLit "FILE_SECURITY_CHECK_FAILED"
    |+| StringLit "FILE_TOO_SHORT"
    |+| StringLit "NETWORK_FAILED"
    |+| StringLit "NETWORK_TIMEOUT"
    |+| StringLit "NETWORK_DISCONNECTED"
    |+| StringLit "NETWORK_SERVER_DOWN"
    |+| StringLit "NETWORK_INVALID_REQUEST"
    |+| StringLit "SERVER_FAILED"
    |+| StringLit "SERVER_NO_RANGE"
    |+| StringLit "SERVER_BAD_CONTENT"
    |+| StringLit "SERVER_UNAUTHORIZED"
    |+| StringLit "SERVER_CERT_PROBLEM"
    |+| StringLit "SERVER_FORBIDDEN"
    |+| StringLit "USER_CANCELED"
    |+| StringLit "USER_SHUTDOWN"
    |+| StringLit "CRASH"
