module JavaScript.Chrome.Extension where

import Effect (Effect)

foreign import inIncognitoContext :: Effect Boolean
