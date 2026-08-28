module JavaScript.Web.DOM.Globals (window, document, location, localStorage) where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.Document (Document)
import JavaScript.Web.DOM.Location (Location)
import JavaScript.Web.DOM.Window (Window)
import JavaScript.Web.DOM.Window as Window
import JavaScript.Web.WebStorage.Storage (Storage)

foreign import _window :: Effect Window

window ∷ Effect Window
window = _window

document :: Effect Document
document = window >>= Window.document

location :: Effect Location
location = window >>= Window.location

localStorage :: Effect Storage
localStorage = window >>= Window.localStorage
