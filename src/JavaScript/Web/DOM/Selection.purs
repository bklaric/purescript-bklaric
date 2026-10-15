module JavaScript.Web.DOM.Selection (Selection, isCollapsed, rangeCount, getRangeAt) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.DOM.Range (Range)

-- https://developer.mozilla.org/en-US/docs/Web/API/Selection

foreign import data Selection :: Type

foreign import isCollapsed :: Selection -> Effect Boolean

foreign import rangeCount :: Selection -> Effect Int

foreign import _getRangeAt :: Int -> Selection -> Effect (Nullable Range)

-- | The selection's range at the index, or `Nothing` past its last one.
getRangeAt :: Int -> Selection -> Effect (Maybe Range)
getRangeAt index selection = _getRangeAt index selection <#> toMaybe
