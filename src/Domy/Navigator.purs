module Domy.Navigator where

import Effect (Effect)

foreign import data Navigator :: Type

foreign import userAgent :: Navigator -> Effect String

foreign import language :: Navigator -> Effect String

foreign import languages :: Navigator -> Effect (Array String)
