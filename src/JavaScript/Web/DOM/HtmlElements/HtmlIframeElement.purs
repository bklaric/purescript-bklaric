module JavaScript.Web.DOM.HtmlElements.HTMLIFrameElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.DOM.Class.Element (class Element, childrenDefault, classListDefault, classNameDefault, getAttributeDefault, getBoundingClientRectDefault, idDefault, innerHtmlDefault, insertAdjacentHTMLDefault, outerHtmlDefault, querySelectorAllDefault, querySelectorDefault, removeAttributeDefault, removeDefault, replaceWithDefault, scrollHeightDefault, scrollLeftDefault, scrollTopDefault, scrollWidthDefault, setClassNameDefault, setIdDefault, setInnerHtmlDefault, setOuterHtmlDefault, setScrollLeftDefault, setScrollTopDefault)
import JavaScript.DOM.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)
import JavaScript.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, setStyleDefault, styleDefault)
import JavaScript.DOM.Class.Node (class Node, appendChildDefault, insertBeforeDefault, parentElementDefault, setTextContentDefault, textContentDefault)
import JavaScript.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlIframeElement :: Type

instance EventTarget HtmlIframeElement where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

instance Node HtmlIframeElement where
    parentElement = parentElementDefault
    appendChild = appendChildDefault
    textContent = textContentDefault
    setTextContent = setTextContentDefault
    insertBefore = insertBeforeDefault

instance Element HtmlIframeElement where
    getBoundingClientRect = getBoundingClientRectDefault
    getAttribute = getAttributeDefault
    removeAttribute = removeAttributeDefault
    innerHtml = innerHtmlDefault
    setInnerHtml = setInnerHtmlDefault
    outerHtml = outerHtmlDefault
    setOuterHtml = setOuterHtmlDefault
    insertAdjacentHTML = insertAdjacentHTMLDefault
    replaceWith = replaceWithDefault
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

instance HtmlElement HtmlIframeElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault
    setStyle = setStyleDefault

readHtmlIframeElement :: forall object. object -> Maybe HtmlIframeElement
readHtmlIframeElement = unsafeReadProtoTagged "HTMLIframeElement"

foreign import src :: HtmlIframeElement -> Effect String
foreign import setSrc :: String -> HtmlIframeElement -> Effect Unit
