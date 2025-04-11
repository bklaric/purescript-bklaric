module JavaScript.Web.File.Blob (Blob, new, new_, type_) where

import Effect (Effect)
import Literals.Undefined (undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Web/API/Blob

foreign import data Blob :: Type

foreign import _new :: UndefinedOr (Array (Blob |+| String)) -> UndefinedOr {type :: UndefinedOr String} -> Effect Blob

new :: forall blobParts options.
    Castable blobParts (UndefinedOr (Array (Blob |+| String))) =>
    Castable options (UndefinedOr {type :: UndefinedOr String}) =>
    blobParts -> options -> Effect Blob
new blobParts options = _new (cast blobParts) (cast options)

new_ :: forall blobParts.
    Castable blobParts (UndefinedOr (Array (Blob |+| String))) =>
    blobParts -> Effect Blob
new_ blobParts = new blobParts undefined

foreign import type_ :: Blob -> String
