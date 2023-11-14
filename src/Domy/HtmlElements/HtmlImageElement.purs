module Domy.HtmlElements.HtmlImageElement where

import Prelude

import Data.Maybe (Maybe)
import Domy.Class.Element (class Element, childrenDefault, classListDefault, classNameDefault, getAttributeDefault, getBoundingClientRectDefault, idDefault, innerHtmlDefault, outerHtmlDefault, querySelectorAllDefault, querySelectorDefault, removeAttributeDefault, removeDefault, scrollHeightDefault, scrollLeftDefault, scrollTopDefault, scrollWidthDefault, setClassNameDefault, setIdDefault, setInnerHtmlDefault, setOuterHtmlDefault, setScrollLeftDefault, setScrollTopDefault)
import Domy.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)
import Domy.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, styleDefault)
import Domy.Class.Node (class Node, appendChildDefault, insertBeforeDefault, parentElementDefault, setTextContentDefault, textContentDefault)
import Domy.Utils (unsafeReadProtoTagged)
import Effect (Effect)

foreign import data HtmlImageElement :: Type

instance eventTargetHtmlImageElement :: EventTarget HtmlImageElement where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

instance nodeHtmlImageElement :: Node HtmlImageElement where
    parentElement = parentElementDefault
    appendChild = appendChildDefault
    textContent = textContentDefault
    setTextContent = setTextContentDefault
    insertBefore = insertBeforeDefault

instance elementHtmlImageElement :: Element HtmlImageElement where
    getBoundingClientRect = getBoundingClientRectDefault
    getAttribute = getAttributeDefault
    removeAttribute = removeAttributeDefault
    innerHtml = innerHtmlDefault
    setInnerHtml = setInnerHtmlDefault
    outerHtml = outerHtmlDefault
    setOuterHtml = setOuterHtmlDefault
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

instance htmlElementHtmlImageElement :: HtmlElement HtmlImageElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault

readHtmlImageElement :: forall object. object -> Maybe HtmlImageElement
readHtmlImageElement = unsafeReadProtoTagged "HTMLImageElement"

foreign import width :: HtmlImageElement -> Effect Int
foreign import setWidth :: Int -> HtmlImageElement -> Effect Unit

foreign import height :: HtmlImageElement -> Effect Int
foreign import setHeight :: Int -> HtmlImageElement -> Effect Unit

foreign import naturalWidth :: HtmlImageElement -> Effect Int
foreign import naturalHeight :: HtmlImageElement -> Effect Int

foreign import src :: HtmlImageElement -> Effect String
foreign import setSrc :: String -> HtmlImageElement -> Effect Unit

foreign import complete :: HtmlImageElement -> Effect Boolean
