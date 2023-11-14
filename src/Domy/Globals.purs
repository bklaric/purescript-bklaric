module Domy.Globals (window, document) where

import Prelude

import Domy.Document (Document)
import Domy.Window (Window)
import Domy.Window as Window
import Effect (Effect)

foreign import windowImpl :: Effect Window

window ∷ Effect Window
window = windowImpl

document :: Effect Document
document = window >>= Window.document
