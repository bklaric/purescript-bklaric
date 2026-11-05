-- | A Web Animations `Animation`, as `Element.animate'` answers it.
module JavaScript.Web.DOM.Animation (Animation, cancel) where

import Prelude

import Effect (Effect)

foreign import data Animation :: Type

-- | `animation.cancel()`: stops the effect and takes away what it applied, even a `fill`.
foreign import cancel :: Animation -> Effect Unit
