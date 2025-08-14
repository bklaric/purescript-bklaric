module JavaScript.Chrome.WebRequest.UploadData where

import Data.Nullable (Nullable)
import Foreign (Foreign)

type UploadData =
    { bytes :: Nullable Foreign
    , file :: Nullable String
    }
