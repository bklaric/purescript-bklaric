module JavaScript.Web.DOM.DomRect where

import Effect (Effect)

foreign import data DomRect :: Type

foreign import x :: DomRect -> Effect Number
foreign import y :: DomRect -> Effect Number
foreign import width :: DomRect -> Effect Number
foreign import height :: DomRect -> Effect Number
foreign import top :: DomRect -> Effect Number
foreign import right :: DomRect -> Effect Number
foreign import bottom :: DomRect -> Effect Number
foreign import left :: DomRect -> Effect Number
