module Halogen.HTML.Properties.Extra where

import Prelude

import Halogen.HTML.Properties (IProp, class_)
import Web.HTML.Common (ClassName(..))

class' :: forall r i. String -> IProp (class :: String | r) i
class' = class_ <<< ClassName
