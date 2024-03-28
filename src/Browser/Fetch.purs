module Browser.Fetch
    ( FetchOptionsRow
    , FetchOptions
    , Credentials(..)
    , fetch
    , fetch_
    , fetchPromise
    , fetchPromise_
    ) where

import Prelude

import Browser.Fetch.Response (Response)
import Data.Either (Either(..))
import Data.HTTP.Method (Method)
import Effect (Effect)
import JavaScript.Error (Error)
import Foreign (Foreign, unsafeToForeign)
import Foreign.Object (Object)
import Prim.Row (class Union)
import Promisey (Promise)

type FetchOptionsRow =
    ( method :: Method
    , body :: String
    , credentials :: Credentials
    , headers :: Object String
    )

type FetchOptions = Record FetchOptionsRow

data Credentials = Omit | SameOrigin | Include

credentialsToString :: Credentials -> String
credentialsToString Omit = "omit"
credentialsToString SameOrigin = "same-origin"
credentialsToString Include = "include"

foreign import fetchImpl
    :: String
    -> Foreign
    -> {credentialsToString :: Credentials -> String, methodToString :: Method -> String}
    -> (Response -> Effect Unit)
    -> (Error -> Effect Unit)
    -> Effect Unit

fetch
    :: forall options options'. Union options options' FetchOptionsRow
    => String
    -> Record options
    -> (Either Error Response -> Effect Unit)
    -> Effect Unit
fetch url options' callback =
    fetchImpl url (unsafeToForeign options') {credentialsToString, methodToString: show}
    (Right >>> callback) (Left >>> callback)

fetch_ :: String -> (Either Error Response -> Effect Unit) -> Effect Unit
fetch_ url callback = fetch url {} callback

foreign import fetchPromiseImpl
    :: String
    -> Foreign
    -> {credentialsToString :: Credentials -> String, methodToString :: Method -> String}
    -> Promise Error Response

fetchPromise :: forall options options'. Union options options' FetchOptionsRow => String -> Record options -> Promise Error Response
fetchPromise url options' = fetchPromiseImpl url (unsafeToForeign options') {credentialsToString, methodToString: show}

fetchPromise_ :: String -> Promise Error Response
fetchPromise_ url = fetchPromise url {}
