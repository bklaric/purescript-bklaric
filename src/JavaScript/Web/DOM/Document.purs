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
import JavaScript.Web.DOM.HtmlElements.HtmlElement (HtmlElement)
import JavaScript.Web.DOM.HtmlElements.HtmlHeadElement (HtmlHeadElement, readHtmlHeadElement)
import JavaScript.Web.DOM.HtmlElements.HtmlImageElement (HtmlImageElement)
import JavaScript.Web.DOM.HtmlElements.HtmlInputElement (HtmlInputElement)
import JavaScript.Web.DOM.HtmlElements.HtmlLinkElement (HtmlLinkElement)
import JavaScript.Web.DOM.HtmlElements.HtmlOptionElement (HtmlOptionElement)
import JavaScript.Web.DOM.HtmlElements.HtmlParagraphElement (HtmlParagraphElement)
import JavaScript.Web.DOM.HtmlElements.HtmlSelectElement (HtmlSelectElement)
import JavaScript.Web.DOM.HtmlElements.HtmlSpanElement (HtmlSpanElement)
import JavaScript.Web.DOM.NodeList (NodeList)
import JavaScript.Web.DOM.Utils (toArray, toArrayDefault)
import JavaScript.Web.WebAnimations.DocumentTimeline (DocumentTimeline)
import Literals (StringLit)
import Partial.Unsafe (unsafePartial)
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Union (type (|+|))

foreign import data Document :: Type

instance EventTarget Document

instance Node Document

foreign import _querySelector :: String -> Document -> Effect (Nullable Element)

querySelector :: String -> Document -> Effect (Maybe Element)
querySelector selector document = _querySelector selector document <#> toMaybe

foreign import querySelectorAll :: String -> Document -> Effect NodeList

querySelectorAll' :: String -> Document -> Effect (Array Element)
querySelectorAll' selector document = querySelectorAll selector document >>= toArrayDefault

foreign import _elementFromPoint :: Int -> Int -> Document -> Effect (Nullable Element)

-- | The topmost element at the given viewport (client) coordinates, or `Nothing`
-- | if the point is outside the viewport.
elementFromPoint :: Int -> Int -> Document -> Effect (Maybe Element)
elementFromPoint x y document = _elementFromPoint x y document <#> toMaybe

-- | Every element at the given viewport (client) coordinates, topmost first —
-- | including elements painted *beneath* an overlay at that pixel (the first
-- | entry equals `elementFromPoint`). Empty when the point is outside the viewport.
foreign import elementsFromPoint :: Int -> Int -> Document -> Effect (Array Element)

foreign import _head :: Document -> Effect (Nullable HtmlHeadElement)

head :: Document -> Effect (Maybe HtmlHeadElement)
head document = _head document <#> toMaybe

-- Body returns null for svg images, so it should be nullable.
-- Also null before document fully loaded.
foreign import body :: Document -> Effect HtmlBodyElement

foreign import _documentElement :: Document -> Effect (Nullable Element)

documentElement :: Document -> Effect (Maybe Element)
documentElement document = _documentElement document <#> toMaybe

foreign import _createElement :: String -> Document -> Effect (Nullable Element)

createElement :: String -> Document -> Effect (Maybe Element)
createElement tagName document = _createElement tagName document <#> toMaybe

foreign import _getElementById :: String -> Document -> Effect (Nullable Element)

getElementById :: String -> Document -> Effect (Maybe Element)
getElementById id document = _getElementById id document <#> toMaybe

foreign import getElementsByClassName :: String -> Document -> Effect HtmlCollection

getElementsByClassName' :: String -> Document -> Effect (Array Element)
getElementsByClassName' className document = getElementsByClassName className document >>= toArray

foreign import contentType :: Document -> Effect String

foreign import referrer :: Document -> Effect String

-- | The document's cookies, as the one `name=value; name=value` string the DOM keeps
-- | them in. Cookies marked HttpOnly are absent -- that is what the flag is for -- so a
-- | name that is not here is one script cannot read, not necessarily one that is unset.
foreign import cookie :: Document -> Effect String

foreign import _activeElement :: Document -> Effect (Nullable Element)

-- | The element focus currently sits on. `body` when nothing inside the document is
-- | focused, and null -- so `Nothing` -- while the document is being unloaded.
-- |
-- | This is the document's own idea of focus and says nothing about whether the document
-- | has it; ask `hasFocus` for that. Pass the result through `readHtmlElement` to get
-- | something `focus` can be called on again.
activeElement :: Document -> Effect (Maybe Element)
activeElement document = _activeElement document <#> toMaybe

foreign import hasFocus :: Document -> Effect Boolean

foreign import readyState :: Document -> Effect (StringLit "loading" |+| StringLit "interactive" |+| StringLit "complete")

foreign import timeline :: Document -> Effect DocumentTimeline

createElementHead :: Document -> Effect HtmlHeadElement
createElementHead document = do
    element <- document # createElement "head"
    element >>= readHtmlHeadElement # unsafePartial fromJust # pure

createElementIframe :: Document -> Effect HtmlIframeElement
createElementIframe document = document # _createElement "iframe" <#> unsafeCoerce

createElementImage :: Document -> Effect HtmlImageElement
createElementImage document = document # _createElement "img" <#> unsafeCoerce

createElementDiv :: Document -> Effect HtmlDivElement
createElementDiv document = document # _createElement "div" <#> unsafeCoerce

createElementButton :: Document -> Effect HtmlButtonElement
createElementButton document = document # _createElement "button" <#> unsafeCoerce

createElementCanvas :: Document -> Effect HtmlCanvasElement
createElementCanvas document = document # _createElement "canvas" <#> unsafeCoerce

createElementInput :: Document -> Effect HtmlInputElement
createElementInput document = document # _createElement "input" <#> unsafeCoerce

createElementSpan :: Document -> Effect HtmlSpanElement
createElementSpan document = document # _createElement "span" <#> unsafeCoerce

createElementSelect :: Document -> Effect HtmlSelectElement
createElementSelect document = document # _createElement "select" <#> unsafeCoerce

createElementOption :: Document -> Effect HtmlOptionElement
createElementOption document = document # _createElement "option" <#> unsafeCoerce

createElementParagraph :: Document -> Effect HtmlParagraphElement
createElementParagraph document = document # _createElement "p" <#> unsafeCoerce

createElementB :: Document -> Effect HtmlElement
createElementB document = document # _createElement "b" <#> unsafeCoerce

createElementLink :: Document -> Effect HtmlLinkElement
createElementLink document = document # _createElement "link" <#> unsafeCoerce
