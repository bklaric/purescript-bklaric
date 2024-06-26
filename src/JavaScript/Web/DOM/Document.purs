module JavaScript.DOM.Document where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import JavaScript.DOM.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)
import JavaScript.DOM.Class.Node (class Node, appendChildDefault, insertBeforeDefault, parentElementDefault, setTextContentDefault, textContentDefault)
import JavaScript.DOM.Element (Element)
import JavaScript.DOM.HtmlElements.HtmlBodyElement (HtmlBodyElement)
import JavaScript.DOM.NodeList (NodeList)
import Effect (Effect)
import Literals (StringLit)
import Untagged.Union (type (|+|))

foreign import data Document :: Type

instance eventTargetDocument :: EventTarget Document where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

instance nodeDocument :: Node Document where
    parentElement = parentElementDefault
    appendChild = appendChildDefault
    textContent = textContentDefault
    setTextContent = setTextContentDefault
    insertBefore = insertBeforeDefault

foreign import querySelectorImpl :: String -> Document -> Effect (Nullable Element)

querySelector :: String -> Document -> Effect (Maybe Element)
querySelector selector document = querySelectorImpl selector document <#> toMaybe

foreign import querySelectorAll :: String -> Document -> Effect NodeList

-- Body returns null for svg images, so it should be nullable.
foreign import body :: Document -> Effect HtmlBodyElement

foreign import documentElementImpl :: Document -> Effect (Nullable Element)

documentElement :: Document -> Effect (Maybe Element)
documentElement document = documentElementImpl document <#> toMaybe

foreign import createElementImpl :: String -> Document -> Effect (Nullable Element)

createElement :: String -> Document -> Effect (Maybe Element)
createElement tagName document = createElementImpl tagName document <#> toMaybe

foreign import getElementByIdImpl :: String -> Document -> Effect (Nullable Element)

getElementById :: String -> Document -> Effect (Maybe Element)
getElementById id document = getElementByIdImpl id document <#> toMaybe

foreign import contentType :: Document -> Effect String

foreign import referrer :: Document -> Effect String

foreign import hasFocus :: Document -> Effect Boolean

foreign import readyState :: Document -> Effect (StringLit "loading" |+| StringLit "interactive" |+| StringLit "complete")
