module JavaScript.Npm.ExifReader (load) where

import Data.Either (Either(..))
import Effect (Effect)
import Foreign (Foreign)
import JavaScript.ArrayBuffer (ArrayBuffer)
import JavaScript.Error (Error)

-- https://www.npmjs.com/package/exifreader

foreign import _load :: forall options. (Error -> Either Error Foreign) -> (Foreign -> Either Error Foreign) -> ArrayBuffer -> Record options -> Effect (Either Error Foreign)

-- | `ExifReader.load(buffer, options)`: the metadata in an image file's bytes, read at once. The
-- | tags come back as ExifReader shapes them, grouped by `options.expanded`. Fails for bytes that
-- | aren't an image file it knows.
load :: forall options. ArrayBuffer -> Record options -> Effect (Either Error Foreign)
load = _load Left Right
