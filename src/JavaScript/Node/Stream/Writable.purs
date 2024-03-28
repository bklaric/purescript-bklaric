module JavaScript.Node.Stream.Writable where

import Prelude

import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
import JavaScript.Node.Buffer (Buffer, fromString)
import JavaScript.Node.Encoding (Encoding(..))
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import Undefined (undefined)

class EventEmitter writable <= Writable writable where
    writableHighWaterMark :: writable -> Effect Int
    writableLength :: writable -> Effect Int
    cork :: writable -> Effect Unit
    uncork :: writable -> Effect Unit
    write :: Foreign -> Effect Unit -> writable -> Effect Boolean
    end :: Foreign -> Effect Unit -> writable -> Effect Boolean
    destroy :: Error -> writable -> Effect writable

foreign import defaultWritableHighWaterMark :: forall writable.
    writable -> Effect Int

foreign import defaultWritableLength :: forall writable.
    writable -> Effect Int

foreign import defaultCork :: forall writable.
    writable -> Effect Unit

foreign import defaultUncork :: forall writable.
    writable -> Effect Unit

foreign import defaultWrite :: forall writable.
    Foreign -> Effect Unit -> writable -> Effect Boolean

foreign import defaultEnd :: forall writable.
    Foreign -> Effect Unit -> writable -> Effect Boolean

foreign import defaultDestroy :: forall writable.
    Error -> writable -> Effect writable

writeBuffer :: forall writable. Writable writable =>
    Buffer -> Effect Unit -> writable -> Effect Boolean
writeBuffer buffer callback writable =
    write (unsafeToForeign buffer) callback writable

writeBuffer_ :: forall writable. Writable writable =>
    Buffer -> writable -> Effect Boolean
writeBuffer_ buffer writable = write (unsafeToForeign buffer) (pure unit) writable

writeString :: forall writable. Writable writable =>
    String -> Encoding -> Effect Unit -> writable -> Effect Boolean
writeString string encoding callback writable = do
    buffer <- fromString string encoding
    writeBuffer buffer callback writable

writeString_ :: forall writable. Writable writable =>
    String -> Encoding -> writable -> Effect Boolean
writeString_ string encoding writable =
    writeString string encoding (pure unit) writable

writeString_' :: forall writable. Writable writable =>
    String -> Effect Unit -> writable -> Effect Boolean
writeString_' string callback writable =
    writeString string UTF8 callback writable

writeString__ :: forall writable. Writable writable =>
    String -> writable -> Effect Boolean
writeString__ string writable = writeString_ string UTF8 writable

end_ :: forall writable. Writable writable =>
    Foreign -> writable -> Effect Boolean
end_ toWrite writable = end toWrite (pure unit) writable

end__ :: forall writable. Writable writable =>
    writable -> Effect Boolean
end__ writable = end (unsafeToForeign "") (pure unit) writable

endBuffer :: forall writable. Writable writable =>
    Buffer -> Effect Unit -> writable -> Effect Boolean
endBuffer buffer callback writable = end (unsafeToForeign buffer) callback writable

endBuffer_ :: forall writable. Writable writable =>
    Buffer -> writable -> Effect Boolean
endBuffer_ buffer writable = end (unsafeToForeign buffer) (pure unit) writable

endString :: forall writable. Writable writable =>
    String -> Encoding -> Effect Unit -> writable -> Effect Boolean
endString string encoding callback writable = do
    buffer <- fromString string encoding
    endBuffer buffer callback writable

endString_ :: forall writable. Writable writable =>
    String -> Encoding -> writable -> Effect Boolean
endString_ string encoding writable =
    endString string encoding (pure unit) writable

endString_' :: forall writable. Writable writable =>
    String -> Effect Unit -> writable -> Effect Boolean
endString_' string callback writable = endString string UTF8 callback writable

endString__ :: forall writable. Writable writable =>
    String -> writable -> Effect Boolean
endString__ string writable = endString_ string UTF8 writable

destroy_ :: forall writable. Writable writable =>
    writable -> Effect writable
destroy_ writable = destroy undefined writable
