module Domy.Class.Node where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Domy.Class.EventTarget (class EventTarget)
import Domy.Element (Element)
import Effect (Effect)

class EventTarget node <= Node node where
    parentElement :: node -> Effect (Maybe Element)
    appendChild :: forall child. Node child => child -> node -> Effect Unit
    textContent :: node -> Effect String
    setTextContent :: String -> node -> Effect Unit
    insertBefore :: forall new reference. Node new => Node reference => new -> reference -> node -> Effect Unit

instance nodeElement :: Node Element where
    parentElement = parentElementDefault
    appendChild = appendChildDefault
    textContent = textContentDefault
    setTextContent = setTextContentDefault
    insertBefore = insertBeforeDefault

foreign import parentElementImpl :: forall node. node -> Effect (Nullable Element)

parentElementDefault :: forall node. node -> Effect (Maybe Element)
parentElementDefault node = parentElementImpl node <#> toMaybe

foreign import appendChildDefault :: forall node child. child -> node -> Effect Unit

foreign import textContentDefault :: forall node. node -> Effect String

foreign import setTextContentDefault :: forall node. String -> node -> Effect Unit

foreign import insertBeforeDefault :: forall node new reference. new -> reference -> node -> Effect Unit
