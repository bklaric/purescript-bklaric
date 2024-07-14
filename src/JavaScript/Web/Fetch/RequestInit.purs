module JavaScript.Web.Fetch.RequestInit where

import Foreign (Foreign)
import Foreign.Object (Object)
import JavaScript.Web.Fetch.Headers (Headers)
import JavaScript.Web.File.Blob (Blob)
import Literals (StringLit)
import Literals.Undefined (Undefined)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Web/API/RequestInit

type RequestInit =
    { body :: Undefined |+| String |+| Blob |+| Foreign
    , credentials :: Undefined |+| StringLit "omit" |+| StringLit "same-origin" |+| StringLit "include"
    , headers :: Undefined |+| Headers |+| Object String
    , method :: Undefined |+| String
    }
