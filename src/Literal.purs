module Literal where

import Prelude

import Control.Monad.Except (except, runExcept)
import Data.Either (Either(..), note)
import Data.List.NonEmpty as NonEmptyList
import Data.Maybe (Maybe(..))
import Data.Symbol (class IsSymbol, reflectSymbol)
import Foreign (ForeignError(..), readString)
import Type.Proxy (Proxy(..))
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Castable (class Castable)
import Untagged.TypeCheck (class HasRuntimeType)
import Yoga.JSON (class ReadForeign, class WriteForeign)

foreign import data Literal :: Symbol -> Type

instance Eq (Literal sym) where
    eq _ _ = true

instance IsSymbol sym => Show (Literal sym) where
    show _ = "(Literal \"" <> reflectSymbol (Proxy :: _ sym) <> "\")"

instance Castable String (Literal symbol)

instance Castable (Literal symbol) String

instance IsSymbol symbol => HasRuntimeType (Literal symbol) where
    hasRuntimeType _ foreign_ =
        case readString foreign_ # runExcept of
        Right string -> string == reflectSymbol (Proxy :: _ symbol)
        Left _ -> false

instance WriteForeign (Literal symbol) where
    writeImpl = unsafeCoerce

instance IsSymbol symbol => ReadForeign (Literal symbol) where
    readImpl value = value # readString >>= \string ->
        string
        # toLiteral
        # note (NonEmptyList.singleton $ ForeignError
            $ "Cannot convert string \"" <> string <> "\" to " <> show (literal :: Literal symbol))
        # except

literal :: forall symbol. IsSymbol symbol => Literal symbol
literal = unsafeCoerce $ reflectSymbol (Proxy :: _ symbol)

toLiteral :: forall symbol. IsSymbol symbol => String -> Maybe (Literal symbol)
toLiteral string =
    if string == reflectSymbol (Proxy :: _ symbol)
    then Just $ unsafeCoerce string
    else Nothing
