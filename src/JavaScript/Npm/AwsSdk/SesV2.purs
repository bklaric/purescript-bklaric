module JavaScript.Npm.AwsSdk.SesV2 (SesV2Client, Credentials, ClientConfig, newClient, SendEmailParams, sendEmail) where

import Prelude

import Effect (Effect)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)

-- https://www.npmjs.com/package/@aws-sdk/client-sesv2

foreign import data SesV2Client :: Type

type Credentials =
    { accessKeyId :: String
    , secretAccessKey :: String
    }

-- No endpoint field: the SDK reads AWS_ENDPOINT_URL_SESV2, or AWS_ENDPOINT_URL,
-- from the environment, which is how a local stack points this client at
-- something other than real SES.
type ClientConfig =
    { credentials :: Credentials
    , region :: String
    }

foreign import newClient :: ClientConfig -> Effect SesV2Client

-- A simple message of SendEmailCommand, in the spelling the rest of this
-- library uses; the FFI maps these onto the command's nested, capitalized keys
-- and marks every part UTF-8, since SES otherwise assumes ASCII.
type SendEmailParams =
    { fromEmailAddress :: String
    , toAddresses :: Array String
    , subject :: String
    , text :: String
    , html :: String
    }

foreign import sendEmail :: SendEmailParams -> SesV2Client -> Promise Error Unit
