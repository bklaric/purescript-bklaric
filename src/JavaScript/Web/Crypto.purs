module JavaScript.Web.Crypto where

import Effect (Effect)

foreign import randomUUID :: Effect String
