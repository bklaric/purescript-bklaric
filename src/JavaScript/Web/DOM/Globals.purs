module JavaScript.DOM.Globals (window, document) where

import Prelude

import JavaScript.DOM.Document (Document)
import JavaScript.DOM.Window (Window)
import JavaScript.DOM.Window as Window
import Effect (Effect)

foreign import windowImpl :: Effect Window

window ∷ Effect Window
window = windowImpl

document :: Effect Document
document = window >>= Window.document
