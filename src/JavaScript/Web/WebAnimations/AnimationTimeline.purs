module JavaScript.Web.WebAnimations.AnimationTimeline (AnimationTimeline, currentTime) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.WebAnimations.Class (class AnimationTimeline)

foreign import data AnimationTimeline :: Type

foreign import _currentTime :: forall timeline. timeline -> Effect (Nullable Number)

currentTime :: forall timeline. AnimationTimeline timeline => timeline -> Effect (Maybe Number)
currentTime timeline = timeline # _currentTime <#> toMaybe
