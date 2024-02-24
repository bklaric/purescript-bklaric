module Browser.Fetch.Response
    ( Response
    , status
    , text
    , json
    , blob
    , clone
    ) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Error (Error)
import Foreign (Foreign)
import JavaScript.Web.File.Blob (Blob)

foreign import data Response :: Type

foreign import status :: Response -> Int

foreign import text
    :: (String -> Effect Unit)
    -> Response
    -> Effect Unit

foreign import jsonImpl
    :: (Foreign -> Effect Unit)
    -> (Error -> Effect Unit)
    -> Response
    -> Effect Unit

json :: (Either Error Foreign -> Effect Unit) -> Response -> Effect Unit
json callback = jsonImpl (Right >>> callback) (Left >>> callback)

foreign import blob :: (Blob -> Effect Unit) -> Response -> Effect Unit

foreign import clone :: Response -> Effect Response
