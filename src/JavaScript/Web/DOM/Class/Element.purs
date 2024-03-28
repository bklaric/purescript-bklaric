module JavaScript.DOM.Class.Element where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import JavaScript.DOM.Class.Node (class Node)
import JavaScript.DOM.DomRect (DomRect)
import JavaScript.DOM.DomTokenList (DomTokenList)
import JavaScript.DOM.Element (Element)
import JavaScript.DOM.HtmlCollection (HtmlCollection)
import JavaScript.DOM.Node (Node)
import JavaScript.DOM.NodeList (NodeList)
import JavaScript.DOM.Utils (toArray)
import Effect (Effect)
import Literals (StringLit)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|), OneOf)

class Node element <= Element element where
    getBoundingClientRect :: element -> Effect DomRect
    getAttribute :: String -> element -> Effect (Maybe String)
    removeAttribute :: String -> element -> Effect Unit
    innerHtml :: element -> Effect String
    setInnerHtml :: String -> element -> Effect Unit
    outerHtml :: element -> Effect String
    setOuterHtml :: String -> element -> Effect Unit
    insertAdjacentHTML :: forall position.
        InOneOf position
            (StringLit "beforebegin")
            (OneOf (StringLit "afterbegin")
            (OneOf (StringLit "beforeend")
            (StringLit "afterend"))) =>
        position -> String -> element -> Effect Unit
    scrollWidth :: element -> Effect Int
    scrollHeight :: element -> Effect Int
    scrollTop :: element -> Effect Int
    scrollLeft :: element -> Effect Int
    setScrollTop :: Int -> element -> Effect Unit
    setScrollLeft :: Int -> element -> Effect Unit
    querySelector :: String -> element -> Effect (Maybe Element)
    querySelectorAll :: String -> element -> Effect NodeList
    id :: element -> Effect String
    setId :: String -> element -> Effect Unit
    className :: element -> Effect String
    setClassName :: String -> element -> Effect Unit
    classList :: element -> Effect DomTokenList
    remove :: element -> Effect Unit
    children :: element -> Effect HtmlCollection

instance elementElement :: Element Element where
    getBoundingClientRect = getBoundingClientRectDefault
    getAttribute = getAttributeDefault
    removeAttribute = removeAttributeDefault
    innerHtml = innerHtmlDefault
    setInnerHtml = setInnerHtmlDefault
    outerHtml = outerHtmlDefault
    setOuterHtml = setOuterHtmlDefault
    insertAdjacentHTML = insertAdjacentHTMLDefault
    scrollWidth = scrollWidthDefault
    scrollHeight = scrollHeightDefault
    scrollTop = scrollTopDefault
    scrollLeft = scrollLeftDefault
    setScrollTop = setScrollTopDefault
    setScrollLeft = setScrollLeftDefault
    querySelector = querySelectorDefault
    querySelectorAll = querySelectorAllDefault
    id = idDefault
    setId = setIdDefault
    className = classNameDefault
    setClassName = setClassNameDefault
    classList = classListDefault
    remove = removeDefault
    children = childrenDefault

foreign import getBoundingClientRectDefault :: forall element. element -> Effect DomRect

foreign import getAttributeDefaultImpl :: forall element. String -> element -> Effect (Nullable String)
getAttributeDefault :: forall element. String -> element -> Effect (Maybe String)
getAttributeDefault name element = getAttributeDefaultImpl name element <#> toMaybe

foreign import removeAttributeDefault :: forall element. String -> element -> Effect Unit

foreign import innerHtmlDefault :: forall element. element -> Effect String
foreign import setInnerHtmlDefault :: forall element. String -> element -> Effect Unit

foreign import outerHtmlDefault :: forall element. element -> Effect String
foreign import setOuterHtmlDefault :: forall element. String -> element -> Effect Unit

foreign import insertAdjacentHTMLDefaultImpl :: forall element.
    StringLit "beforebegin" |+| StringLit "afterbegin" |+| StringLit "beforeend" |+| StringLit "afterend" -> String -> element -> Effect Unit

insertAdjacentHTMLDefault :: forall element position.
    InOneOf position (StringLit "beforebegin") (OneOf (StringLit "afterbegin") (OneOf (StringLit "beforeend") (StringLit "afterend"))) =>
    position -> String -> element -> Effect Unit
insertAdjacentHTMLDefault position text element = insertAdjacentHTMLDefaultImpl (cast position) text element

foreign import scrollWidthDefault :: forall element. element -> Effect Int
foreign import scrollHeightDefault :: forall element. element -> Effect Int

foreign import scrollTopDefault :: forall element. element -> Effect Int
foreign import scrollLeftDefault :: forall element. element -> Effect Int
foreign import setScrollTopDefault :: forall element. Int -> element -> Effect Unit
foreign import setScrollLeftDefault :: forall element. Int -> element -> Effect Unit

foreign import querySelectorImpl :: forall element. String -> element -> Effect (Nullable Element)

querySelectorDefault :: forall element. String -> element -> Effect (Maybe Element)
querySelectorDefault selector element = querySelectorImpl selector element <#> toMaybe

foreign import querySelectorAllDefault :: forall element. String -> element -> Effect NodeList

querySelectorAll' :: forall element. Element element => String -> element -> Effect (Array Node)
querySelectorAll' selector element = querySelectorAll selector element >>= toArray

foreign import idDefault :: forall element. element -> Effect String
foreign import setIdDefault :: forall element. String -> element -> Effect Unit

foreign import classNameDefault :: forall element. element -> Effect String
foreign import setClassNameDefault :: forall element. String -> element -> Effect Unit
foreign import classListDefault :: forall element. element -> Effect DomTokenList
classList' :: forall element. Element element => element -> Effect (Array String)
classList' element = element # classList >>= toArray

foreign import removeDefault :: forall element. element -> Effect Unit

foreign import childrenDefault :: forall element. element -> Effect HtmlCollection
children' :: forall element. Element element => element -> Effect (Array Element)
children' element = element # children >>= toArray
