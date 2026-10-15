module JavaScript.Web.DOM.Range (Range, getBoundingClientRect) where

import Effect (Effect)
import JavaScript.Web.DOM.DomRect (DomRect)

-- https://developer.mozilla.org/en-US/docs/Web/API/Range

foreign import data Range :: Type

foreign import getBoundingClientRect :: Range -> Effect DomRect
