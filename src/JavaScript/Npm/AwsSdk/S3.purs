module JavaScript.Npm.AwsSdk.S3 (S3Client, Credentials, ClientConfig, newClient, PutObjectParams, putObject) where

import Prelude

import Effect (Effect)
import JavaScript.Error (Error)
import JavaScript.Node.Buffer (Buffer)
import JavaScript.Promise (Promise)
import Untagged.Union (UndefinedOr)

-- https://www.npmjs.com/package/@aws-sdk/client-s3

foreign import data S3Client :: Type

type Credentials =
    { accessKeyId :: String
    , secretAccessKey :: String
    }

-- No endpoint field: the SDK reads AWS_ENDPOINT_URL from the environment, which
-- is how a local stack points these clients at something other than real S3.
type ClientConfig =
    { credentials :: Credentials
    , region :: String
    }

foreign import newClient :: ClientConfig -> Effect S3Client

-- The SDK's own PutObjectCommand input, in the spelling the rest of this library
-- uses; the FFI maps these onto its capitalized keys. contentType is optional
-- because S3 picks its own default when the command omits it, and a bucket whose
-- objects are read by key rather than by content type has no reason to set one.
type PutObjectParams =
    { bucket :: String
    , key :: String
    , body :: Buffer
    , contentType :: UndefinedOr String
    }

foreign import putObject :: PutObjectParams -> S3Client -> Promise Error Unit
