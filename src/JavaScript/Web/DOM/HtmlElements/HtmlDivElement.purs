module JavaScript.DOM.HtmlElements.HtmlDivElement where

import Prelude

import Data.Maybe (Maybe, fromJust)
import JavaScript.DOM.Class.Element (class Element, childrenDefault, classListDefault, classNameDefault, getAttributeDefault, getBoundingClientRectDefault, idDefault, innerHtmlDefault, insertAdjacentHTMLDefault, outerHtmlDefault, querySelectorAllDefault, querySelectorDefault, removeAttributeDefault, removeDefault, scrollHeightDefault, scrollLeftDefault, scrollTopDefault, scrollWidthDefault, setClassNameDefault, setIdDefault, setInnerHtmlDefault, setOuterHtmlDefault, setScrollLeftDefault, setScrollTopDefault)
import JavaScript.DOM.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)
import JavaScript.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, styleDefault)
import JavaScript.DOM.Class.Node (class Node, appendChildDefault, insertBeforeDefault, parentElementDefault, setTextContentDefault, textContentDefault)
import JavaScript.DOM.Document (Document, createElement)
import JavaScript.DOM.Utils (unsafeReadProtoTagged)
import Effect (Effect)
import Partial.Unsafe (unsafePartial)

foreign import data HtmlDivElement :: Type

instance EventTarget HtmlDivElement where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

instance Node HtmlDivElement where
    parentElement = parentElementDefault
    appendChild = appendChildDefault
    textContent = textContentDefault
    setTextContent = setTextContentDefault
    insertBefore = insertBeforeDefault

instance Element HtmlDivElement where
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

instance HtmlElement HtmlDivElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault

readHtmlDivElement :: forall object. object -> Maybe HtmlDivElement
readHtmlDivElement = unsafeReadProtoTagged "HTMLDivElement"

createElementDiv :: Document -> Effect HtmlDivElement
createElementDiv document = do
    element <- document # createElement "div"
    element >>= readHtmlDivElement # unsafePartial fromJust # pure
