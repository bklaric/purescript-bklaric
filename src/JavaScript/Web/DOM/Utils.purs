module JavaScript.DOM.Utils where

import Prelude

import Control.Monad.Except (runExcept)
import Data.Either (hush)
import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
import Foreign as Foreign

unsafeReadTagged :: forall object tagged. String -> object -> Maybe tagged
unsafeReadTagged name object = object # unsafeToForeign # Foreign.unsafeReadTagged name # runExcept # hush

foreign import unsafeReadProtoTaggedImpl :: forall node. String -> Foreign -> Nullable node

unsafeReadProtoTagged :: forall anything object. String -> anything -> Maybe object
unsafeReadProtoTagged name object = object # unsafeToForeign # unsafeReadProtoTaggedImpl name # toMaybe

class ToArray a b | a -> b where
    toArray :: a -> Effect (Array b)

foreign import toArrayDefault :: forall a b. a -> Effect (Array b)
