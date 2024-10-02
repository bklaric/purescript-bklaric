module JavaScript.Web.DOM.Document where

import Prelude

import Data.Maybe (Maybe, fromJust)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class EventTarget, class Node)
import JavaScript.Web.DOM.ElementType (Element)
import JavaScript.Web.DOM.HtmlCollection (HtmlCollection)
import JavaScript.Web.DOM.HtmlElements.HTMLIFrameElement (HtmlIframeElement)
import JavaScript.Web.DOM.HtmlElements.HtmlBodyElement (HtmlBodyElement)
import JavaScript.Web.DOM.HtmlElements.HtmlButtonElement (HtmlButtonElement)
import JavaScript.Web.DOM.HtmlElements.HtmlCanvasElement (HtmlCanvasElement)
import JavaScript.Web.DOM.HtmlElements.HtmlDivElement (HtmlDivElement)
import JavaScript.Web.DOM.HtmlElements.HtmlHeadElement (HtmlHeadElement, readHtmlHeadElement)
import JavaScript.Web.DOM.HtmlElements.HtmlImageElement (HtmlImageElement)
import JavaScript.Web.DOM.HtmlElements.HtmlInputElement (HtmlInputElement)
import JavaScript.Web.DOM.HtmlElements.HtmlParagraphElement (HtmlParagraphElement)
import JavaScript.Web.DOM.HtmlElements.HtmlSpanElement (HtmlSpanElement)
import JavaScript.Web.DOM.NodeList (NodeList)
import JavaScript.Web.DOM.Utils (toArray, toArrayDefault)
import Literals (StringLit)
import Partial.Unsafe (unsafePartial)
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Union (type (|+|))

foreign import data Document :: Type

instance EventTarget Document

instance Node Document

foreign import querySelectorImpl :: String -> Document -> Effect (Nullable Element)

querySelector :: String -> Document -> Effect (Maybe Element)
querySelector selector document = querySelectorImpl selector document <#> toMaybe

foreign import querySelectorAll :: String -> Document -> Effect NodeList

querySelectorAll' :: String -> Document -> Effect (Array Element)
querySelectorAll' selector document = querySelectorAll selector document >>= toArrayDefault

foreign import headImpl :: Document -> Effect (Nullable HtmlHeadElement)

head :: Document -> Effect (Maybe HtmlHeadElement)
head document = headImpl document <#> toMaybe

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

foreign import getElementsByClassName :: String -> Document -> Effect HtmlCollection

getElementsByClassName' :: String -> Document -> Effect (Array Element)
getElementsByClassName' className document = getElementsByClassName className document >>= toArray

foreign import contentType :: Document -> Effect String

foreign import referrer :: Document -> Effect String

foreign import hasFocus :: Document -> Effect Boolean

foreign import readyState :: Document -> Effect (StringLit "loading" |+| StringLit "interactive" |+| StringLit "complete")

createElementHead :: Document -> Effect HtmlHeadElement
createElementHead document = do
    element <- document # createElement "head"
    element >>= readHtmlHeadElement # unsafePartial fromJust # pure

createElementIframe :: Document -> Effect HtmlIframeElement
createElementIframe document = document # createElementImpl "iframe" <#> unsafeCoerce

createElementImage :: Document -> Effect HtmlImageElement
createElementImage document = document # createElementImpl "img" <#> unsafeCoerce

createElementDiv :: Document -> Effect HtmlDivElement
createElementDiv document = document # createElementImpl "div" <#> unsafeCoerce

createElementButton :: Document -> Effect HtmlButtonElement
createElementButton document = document # createElementImpl "button" <#> unsafeCoerce

createElementCanvas :: Document -> Effect HtmlCanvasElement
createElementCanvas document = document # createElementImpl "canvas" <#> unsafeCoerce

createElementInput :: Document -> Effect HtmlInputElement
createElementInput document = document # createElementImpl "input" <#> unsafeCoerce

createElementSpan :: Document -> Effect HtmlSpanElement
createElementSpan document = document # createElementImpl "span" <#> unsafeCoerce

createElementParagraph :: Document -> Effect HtmlParagraphElement
createElementParagraph document = document # createElementImpl "p" <#> unsafeCoerce
