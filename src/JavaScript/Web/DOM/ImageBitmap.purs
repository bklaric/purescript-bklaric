module JavaScript.Web.DOM.ImageBitmap (ImageBitmap, ImageBitmapSource, createImageBitmap, close) where

import Prelude

import Effect (Effect)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import JavaScript.Web.DOM.HtmlElements.HtmlImageElement (HtmlImageElement)
import JavaScript.Web.File.Blob (Blob)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Web/API/ImageBitmap

foreign import data ImageBitmap :: Type

-- https://developer.mozilla.org/en-US/docs/Web/API/Window/createImageBitmap#image
type ImageBitmapSource = HtmlImageElement |+| Blob

foreign import _createImageBitmap :: ImageBitmapSource -> Promise Error ImageBitmap

-- | Decodes the source into a bitmap. Rejects for an image that hasn't loaded, or one the browser
-- | can't decode into a bitmap, which in Chrome includes an SVG blob.
createImageBitmap :: forall source. Castable source ImageBitmapSource => source -> Promise Error ImageBitmap
createImageBitmap source = _createImageBitmap (cast source)

-- | Releases the bitmap's pixels now rather than whenever it is collected.
foreign import close :: ImageBitmap -> Effect Unit
