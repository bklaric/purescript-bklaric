module JavaScript.Web.DOM.MutationObserver
  ( MutationObserver
  , MutationObserverOptions
  , new
  , observe
  , disconnect
  , takeRecords
  ) where

import Prelude

import Effect (Effect)
import Prim.Row (class Union)
import JavaScript.Web.DOM.MutationRecord (MutationRecord)
import JavaScript.Web.DOM.Class (class Node)

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

foreign import new ::
  ((Array MutationRecord) -> MutationObserver -> Effect Unit) -> Effect MutationObserver

foreign import _observe :: forall node options. node -> Record options -> MutationObserver -> Effect Unit

observe :: forall node r rx. Node node => Union r rx MutationObserverOptions =>
    node -> Record r -> MutationObserver -> Effect Unit
observe = _observe

foreign import disconnect :: MutationObserver -> Effect Unit

foreign import takeRecords :: MutationObserver -> Effect (Array MutationRecord)
