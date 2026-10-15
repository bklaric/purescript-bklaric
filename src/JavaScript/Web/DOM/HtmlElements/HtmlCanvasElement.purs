module JavaScript.Web.DOM.HtmlElements.HtmlCanvasElement (HtmlCanvasElement, readHtmlCanvasElement, width, height, setWidth, setHeight, toBlob, CanvasRenderingContext2D, drawImage, CanvasImageSource, drawImageScaled, getContext2D, getContextBitmapRendering) where

import Prelude

import Data.Either (Either(..))
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Error (Error)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.HtmlElements.HtmlImageElement (HtmlImageElement)
import JavaScript.Web.DOM.ImageBitmap (ImageBitmap)
import JavaScript.Web.DOM.ImageBitmapRenderingContext (ImageBitmapRenderingContext)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)
import JavaScript.Web.File.Blob (Blob)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Web/API/HTMLCanvasElement

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

foreign import _toBlob :: (Error -> Either Error (Maybe Blob)) -> (Nullable Blob -> Either Error (Maybe Blob)) -> (Either Error (Maybe Blob) -> Effect Unit) -> HtmlCanvasElement -> Effect Unit

toBlob :: (Either Error (Maybe Blob) -> Effect Unit) -> HtmlCanvasElement -> Effect Unit
toBlob callback canvas = _toBlob Left (toMaybe >>> Right) callback canvas

-- Rendering contexts.

foreign import data CanvasRenderingContext2D :: Type

foreign import drawImage :: HtmlImageElement -> Int -> Int -> CanvasRenderingContext2D -> Effect Unit

-- https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage#image
type CanvasImageSource = HtmlImageElement |+| ImageBitmap |+| HtmlCanvasElement

foreign import _drawImageScaled :: CanvasImageSource -> Number -> Number -> Number -> Number -> CanvasRenderingContext2D -> Effect Unit

-- | Draws the source stretched to the given box, rather than at its own size.
drawImageScaled :: forall source. Castable source CanvasImageSource =>
    source -> Number -> Number -> Number -> Number -> CanvasRenderingContext2D -> Effect Unit
drawImageScaled source = _drawImageScaled (cast source)

foreign import _getContext2D :: HtmlCanvasElement -> Effect (Nullable CanvasRenderingContext2D)

getContext2D :: HtmlCanvasElement -> Effect (Maybe CanvasRenderingContext2D)
getContext2D canvas = _getContext2D canvas <#> toMaybe

foreign import getContextBitmapRendering :: HtmlCanvasElement -> Effect (Nullable ImageBitmapRenderingContext)
