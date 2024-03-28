module JavaScript.DOM.MutationObserver
  ( MutationObserver
  , MutationObserverOptions
  , mutationObserver
  , observe
  , disconnect
  , takeRecords
  ) where

import Prelude

import Effect (Effect)
import Prim.Row (class Union)
import JavaScript.DOM.MutationRecord (MutationRecord)
import JavaScript.DOM.Class.Node (class Node)

foreign import data MutationObserver :: Type

type MutationObserverOptions =
    ( childList :: Boolean
    , attributes :: Boolean
    , characterData :: Boolean
    , subtree :: Boolean
    , attributeOldValue :: Boolean
    , characterDataOldValue :: Boolean
    , attributeFilter :: Array String
    )

foreign import mutationObserver ::
  ((Array MutationRecord) -> MutationObserver -> Effect Unit) -> Effect MutationObserver

foreign import observeImpl :: forall node options. node -> Record options -> MutationObserver -> Effect Unit

observe :: forall node r rx. Node node => Union r rx MutationObserverOptions =>
    node -> Record r -> MutationObserver -> Effect Unit
observe = observeImpl

foreign import disconnect :: MutationObserver -> Effect Unit

foreign import takeRecords :: MutationObserver -> Effect (Array MutationRecord)
