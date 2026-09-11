module JavaScript.Npm.Sendgrid (Message, setApiKey, send) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Errors (Error)
import JavaScript.Promise (Promise)

-- https://github.com/sendgrid/sendgrid-nodejs/tree/main/packages/mail

type Message =
    { to :: String
    , from :: String
    , subject :: String
    , text :: String
    , html :: String
    }

-- | Sets the key for every later `send`; the client keeps it in module state.
foreign import setApiKey :: String -> Effect Unit

-- | Rejects with a Node-shaped error carrying a `code`, so failures read the
-- | same way as the rest of the Node bindings.
foreign import send :: Message -> Promise Error Unit
