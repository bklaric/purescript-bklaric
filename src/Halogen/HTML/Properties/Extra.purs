module Halogen.HTML.Properties.Extra where

import Prelude

import Halogen.HTML.Properties (IProp, attr, class_)
import Web.HTML.Common (AttrName(..), ClassName(..))

class' :: forall r i. String -> IProp (class :: String | r) i
class' = class_ <<< ClassName

attr' :: forall r i. String -> String -> IProp r i
attr' name value = attr (AttrName name) value
