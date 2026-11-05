-- https://developer.mozilla.org/en-US/docs/Web/API/FontFaceSet
module JavaScript.Web.DOM.FontFaceSet
  ( FontFaceSet
  , fonts
  , load
  ) where

import Prelude

import Effect (Effect)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import JavaScript.Web.DOM.Document (Document)

foreign import data FontFaceSet :: Type

-- | The document's font faces, `document.fonts`.
foreign import fonts :: Document -> Effect FontFaceSet

-- | Load the faces a CSS `font` shorthand (`"1em Inter"`) needs, resolving once they have, and
-- | at once when no face matches.
foreign import load :: String -> FontFaceSet -> Promise Error Unit
