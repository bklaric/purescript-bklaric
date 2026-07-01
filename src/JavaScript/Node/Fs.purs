module JavaScript.Node.Fs
    ( readFileSync
    , readFileSyncString
    , readFileSyncBuffer
    , readFileSyncBuffer_
    , writeFileSync
    , mkdirSync
    , rmSync
    ) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import JavaScript.Node.Buffer (Buffer, Encoding)
import JavaScript.Node.Errors (Error)
import Literals.Null (Null)
import Literals.Undefined (Undefined, undefined)
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Castable (cast)
import Untagged.Union (class InOneOf, type (|+|), UndefinedOr)

foreign import readFileSyncImpl
    :: (Error -> Either Error (String |+| Buffer))
    -> (String |+| Buffer -> Either Error (String |+| Buffer))
    -> String |+| Buffer |+| Int -- |+| URL
    -> Undefined |+| Encoding |+| {encoding :: Undefined |+| Null |+| Encoding, flag :: UndefinedOr String}
    -> Effect (Either Error (String |+| Buffer))

readFileSync
    :: forall path options
    .  InOneOf path String (Buffer |+| Int)
    => InOneOf options Undefined (Encoding |+| {encoding :: Undefined |+| Null |+| Encoding, flag :: UndefinedOr String})
    => path
    -> options
    -> Effect (Either Error (String |+| Buffer))
readFileSync path options = readFileSyncImpl Left Right (cast path) (cast options)

readFileSyncString
    :: forall path options
    .  InOneOf path String (Buffer |+| Int)
    => InOneOf options {encoding :: Encoding, flag :: UndefinedOr String} Encoding
    => path
    -> options
    -> Effect (Either Error String)
readFileSyncString path options = readFileSyncString' (cast path) (cast options)
    where
    readFileSyncString'
        :: String |+| Buffer |+| Int
        -> {encoding :: Encoding, flag :: UndefinedOr String} |+| Encoding
        -> Effect (Either Error String)
    readFileSyncString' path' options' = readFileSyncImpl Left Right path' (unsafeCoerce options') <#> unsafeCoerce

readFileSyncBuffer
    :: forall path options
    .  InOneOf path String (Buffer |+| Int)
    => InOneOf options Undefined {encoding :: UndefinedOr Null, flag :: UndefinedOr String}
    => path
    -> options
    -> Effect (Either Error Buffer)
readFileSyncBuffer path options = readFileSyncBuffer' (cast path) (cast options)
    where
    readFileSyncBuffer'
        :: String |+| Buffer |+| Int
        -> UndefinedOr {encoding :: UndefinedOr Null, flag :: UndefinedOr String}
        -> Effect (Either Error Buffer)
    readFileSyncBuffer' path' options' = readFileSyncImpl Left Right path' (unsafeCoerce options') <#> unsafeCoerce

readFileSyncBuffer_ :: forall path. InOneOf path String (Buffer |+| Int) => path -> Effect (Either Error Buffer)
readFileSyncBuffer_ path = readFileSyncBuffer path undefined

foreign import writeFileSyncImpl :: String -> (String |+| Buffer) -> Effect Unit

-- Write a string or a Buffer to a file, replacing it if it exists. Throws on failure.
writeFileSync :: forall data_. InOneOf data_ String Buffer => String -> data_ -> Effect Unit
writeFileSync path data_ = writeFileSyncImpl path (cast data_)

-- Create a directory. `recursive: true` creates missing parents and is a no-op if it already exists.
foreign import mkdirSync :: String -> { recursive :: Boolean } -> Effect Unit

-- Remove a file or directory. `recursive: true` removes a non-empty directory; `force: true`
-- ignores a missing path instead of throwing.
foreign import rmSync :: String -> { recursive :: Boolean, force :: Boolean } -> Effect Unit
