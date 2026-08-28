module Postmark.Client (Client, create, sendEmail) where

import Prelude

import Data.Either (Either(..))
import Foreign (Foreign)
import Effect (Effect)
import Postmark.Error (Error)
import Postmark.Message (Message)

foreign import data Client :: Type

foreign import create :: String -> Effect Client

foreign import _sendEmail
    :: Message
    -> (Error -> Effect Unit)
    -> (Foreign -> Effect Unit)
    -> Client
    -> Effect Unit

sendEmail
    :: Message
    -> (Either Error Foreign -> Effect Unit)
    -> Client
    -> Effect Unit
sendEmail message callback client =
    _sendEmail message (Left >>> callback) (Right >>> callback) client
