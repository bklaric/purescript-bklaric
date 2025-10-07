module JavaScript.Web.DOM.DocumentFragment (DocumentFragment, querySelector, querySelectorAll, querySelectorAll') where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class DocumentFragment, class EventTarget, class Node)
import JavaScript.Web.DOM.ElementType (Element)
import JavaScript.Web.DOM.NodeList (NodeList)
import JavaScript.Web.DOM.Utils (toArrayDefault)

-- https://developer.mozilla.org/en-US/docs/Web/API/DocumentFragment

foreign import data DocumentFragment :: Type

instance EventTarget DocumentFragment

instance Node DocumentFragment

instance DocumentFragment DocumentFragment

foreign import _querySelector :: forall element. String -> element -> Effect (Nullable Element)

querySelector :: forall element. DocumentFragment element => String -> element -> Effect (Maybe Element)
querySelector selector element = _querySelector selector element <#> toMaybe

foreign import _querySelectorAll :: forall element. String -> element -> Effect NodeList

querySelectorAll :: forall element. DocumentFragment element => String -> element -> Effect NodeList
querySelectorAll = _querySelectorAll

querySelectorAll' :: forall element. DocumentFragment element => String -> element -> Effect (Array Element)
querySelectorAll' selector element = querySelectorAll selector element >>= toArrayDefault
