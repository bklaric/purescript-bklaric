module JavaScript.Node.Zlib (gzipSync) where

import Effect (Effect)
import JavaScript.Node.Buffer (Buffer)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|))

-- https://nodejs.org/api/zlib.html

foreign import gzipSyncImpl :: (String |+| Buffer) -> Effect Buffer

gzipSync :: forall input. InOneOf input String Buffer => input -> Effect Buffer
gzipSync input = gzipSyncImpl (cast input)
