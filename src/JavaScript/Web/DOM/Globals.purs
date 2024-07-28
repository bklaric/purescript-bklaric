module JavaScript.Web.DOM.Globals (window, document) where

import Prelude

import JavaScript.Web.DOM.Document (Document)
import JavaScript.Web.DOM.Window (Window)
import JavaScript.Web.DOM.Window as Window
import Effect (Effect)

foreign import windowImpl :: Effect Window

window ∷ Effect Window
window = windowImpl

document :: Effect Document
document = window >>= Window.document
