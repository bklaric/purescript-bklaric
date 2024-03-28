module JavaScript.DOM.HtmlElements.HtmlSpanElement where

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

foreign import data HtmlSpanElement :: Type

instance EventTarget HtmlSpanElement where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

instance Node HtmlSpanElement where
    parentElement = parentElementDefault
    appendChild = appendChildDefault
    textContent = textContentDefault
    setTextContent = setTextContentDefault
    insertBefore = insertBeforeDefault

instance Element HtmlSpanElement where
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

instance HtmlElement HtmlSpanElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault

readHtmlSpanElement :: forall object. object -> Maybe HtmlSpanElement
readHtmlSpanElement = unsafeReadProtoTagged "HTMLSpanElement"

createElementSpan :: Document -> Effect HtmlSpanElement
createElementSpan document = do
    element <- document # createElement "span"
    element >>= readHtmlSpanElement # unsafePartial fromJust # pure
