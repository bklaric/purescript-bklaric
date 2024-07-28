module JavaScript.Web.DOM.Node where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.Element (Element)

foreign import data Node :: Type

instance EventTarget Node

instance Node Node

foreign import _parentElement :: forall node. node -> Effect (Nullable Element)
foreign import _appendChild :: forall node child. child -> node -> Effect Unit
foreign import _textContent :: forall node. node -> Effect String
foreign import _setTextContent :: forall node. String -> node -> Effect Unit
foreign import _insertBefore :: forall node new reference. new -> reference -> node -> Effect Unit

parentElement :: forall node. Node node => node -> Effect (Maybe Element)
parentElement node = _parentElement node <#> toMaybe

appendChild :: forall node child. Node child => Node node => child -> node -> Effect Unit
appendChild = _appendChild

textContent :: forall node. Node node => node -> Effect String
textContent = _textContent

setTextContent :: forall node. Node node => String -> node -> Effect Unit
setTextContent = _setTextContent

insertBefore :: forall node new reference. Node new => Node reference => Node node => new -> reference -> node -> Effect Unit
insertBefore = _insertBefore
