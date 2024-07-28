module JavaScript.DOM.HtmlElements.HtmlCanvasElement where

import Prelude

import Data.Maybe (Maybe, fromJust)
import Data.Nullable (Nullable)
import Effect (Effect)
import JavaScript.DOM.Class.Element (class Element, childrenDefault, classListDefault, classNameDefault, getAttributeDefault, getBoundingClientRectDefault, idDefault, innerHtmlDefault, insertAdjacentHTMLDefault, outerHtmlDefault, querySelectorAllDefault, querySelectorDefault, removeAttributeDefault, removeDefault, replaceWithDefault, scrollHeightDefault, scrollLeftDefault, scrollTopDefault, scrollWidthDefault, setClassNameDefault, setIdDefault, setInnerHtmlDefault, setOuterHtmlDefault, setScrollLeftDefault, setScrollTopDefault)
import JavaScript.DOM.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)
import JavaScript.DOM.Class.HtmlElement (class HtmlElement, offsetHeightDefault, offsetWidthDefault, setStyleDefault, styleDefault)
import JavaScript.DOM.Class.Node (class Node, appendChildDefault, insertBeforeDefault, parentElementDefault, setTextContentDefault, textContentDefault)
import JavaScript.DOM.Document (Document, createElement)
import JavaScript.DOM.HtmlElements.HtmlImageElement (HtmlImageElement)
import JavaScript.DOM.Utils (unsafeReadProtoTagged)
import JavaScript.Web.File.Blob (Blob)
import Partial.Unsafe (unsafePartial)
import Unsafe.Coerce (unsafeCoerce)

foreign import data HtmlCanvasElement :: Type

instance EventTarget HtmlCanvasElement where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

instance Node HtmlCanvasElement where
    parentElement = parentElementDefault
    appendChild = appendChildDefault
    textContent = textContentDefault
    setTextContent = setTextContentDefault
    insertBefore = insertBeforeDefault

instance Element HtmlCanvasElement where
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

instance HtmlElement HtmlCanvasElement where
    offsetWidth = offsetWidthDefault
    offsetHeight = offsetHeightDefault
    style = styleDefault
    setStyle = setStyleDefault

readHtmlCanvasElement :: forall object. object -> Maybe HtmlCanvasElement
readHtmlCanvasElement = unsafeReadProtoTagged "HTMLCanvasElement"

createElementCanvas :: Document -> Effect HtmlCanvasElement
createElementCanvas document =
    document # createElement "canvas" <#> unsafePartial fromJust <#> unsafeCoerce

foreign import width :: HtmlCanvasElement -> Effect Int

foreign import height :: HtmlCanvasElement -> Effect Int

foreign import setWidth :: Int -> HtmlCanvasElement -> Effect Unit

foreign import setHeight :: Int -> HtmlCanvasElement -> Effect Unit

foreign import toBlob :: (Blob -> Effect Unit) -> HtmlCanvasElement -> Effect Unit

-- Rendering contexts.

foreign import data CanvasRenderingContext2D :: Type

foreign import drawImage :: HtmlImageElement -> Int -> Int -> CanvasRenderingContext2D -> Effect Unit

foreign import data ImageBitmapRenderingContext :: Type

foreign import getContext2D :: HtmlCanvasElement -> Effect (Nullable CanvasRenderingContext2D)

foreign import getContextBitmapRendering :: HtmlCanvasElement -> Effect (Nullable ImageBitmapRenderingContext)

foreign import data ImageBitmap :: Type

foreign import createImageBitmapImpl :: HtmlImageElement -> Effect (Nullable ImageBitmap)

createImageBitmap :: HtmlImageElement -> Effect (Nullable ImageBitmap)
createImageBitmap = createImageBitmapImpl
