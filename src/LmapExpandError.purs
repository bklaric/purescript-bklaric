module LmapExpandError where

import Prelude

import Data.Bifunctor (class Bifunctor, lmap)
import JavaScript.Class (class Error)
import JavaScript.Error (Error)
import JavaScript.Error as Error

lmapExpandError :: forall bifunctor right error. Bifunctor bifunctor => Error error =>
    String -> bifunctor error right -> bifunctor Error right
lmapExpandError message = lmap \error -> Error.new $ message <> " | " <> Error.message error
