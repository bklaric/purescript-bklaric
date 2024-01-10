module Node.Buffer.Foreign where

import Prelude

import Control.Monad.Except (runExcept)
import Data.Either (Either)
import Foreign (F, Foreign, ForeignError, unsafeReadTagged)
import Data.List.Types (NonEmptyList)
import Node.Buffer (Buffer)

bufferTag :: String
bufferTag = "Uint8Array"

fromForeign :: Foreign -> F Buffer
fromForeign foreignBuffer = unsafeReadTagged bufferTag foreignBuffer

fromForeign' :: Foreign -> Either (NonEmptyList ForeignError) Buffer
fromForeign' foreignBuffer = fromForeign foreignBuffer # runExcept
