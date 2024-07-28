module JavaScript.Web.DOM.HtmlElements.HtmlCanvasElement where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable)
import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Class.HtmlElement (class HtmlElement)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.HtmlElements.HtmlImageElement (HtmlImageElement)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)
import JavaScript.Web.File.Blob (Blob)

foreign import data HtmlCanvasElement :: Type

instance EventTarget HtmlCanvasElement

instance Node HtmlCanvasElement

instance Element HtmlCanvasElement

instance HtmlElement HtmlCanvasElement

readHtmlCanvasElement :: forall object. object -> Maybe HtmlCanvasElement
readHtmlCanvasElement = unsafeReadProtoTagged "HTMLCanvasElement"

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
