module JavaScript.Web.DOM.Window where

import Prelude

import JavaScript.Web.DOM.Class.EventTarget (class EventTarget)
import JavaScript.Web.DOM.Document (Document)
import JavaScript.Web.DOM.Location (Location)
import JavaScript.Web.DOM.Navigator (Navigator)
import Effect (Effect)
import Undefined (undefined)

foreign import data Window :: Type

instance EventTarget Window

foreign import document :: Window -> Effect Document

foreign import location :: Window -> Effect Location

foreign import navigator :: Window -> Effect Navigator

foreign import innerWidth :: Window -> Effect Int
foreign import innerHeight :: Window -> Effect Int

foreign import scrollBy :: Int -> Int -> Window -> Effect Unit

foreign import open :: String -> String -> String -> Window -> Effect Window

open_ :: String -> String -> Window -> Effect Window
open_ url target window = open url target undefined window
