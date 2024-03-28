module JavaScript.DOM.Window where

import Prelude

import JavaScript.DOM.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)
import JavaScript.DOM.Document (Document)
import JavaScript.DOM.Location (Location)
import JavaScript.DOM.Navigator (Navigator)
import Effect (Effect)
import Undefined (undefined)

foreign import data Window :: Type

instance eventTargetWindow :: EventTarget Window where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

foreign import document :: Window -> Effect Document

foreign import location :: Window -> Effect Location

foreign import navigator :: Window -> Effect Navigator

foreign import innerWidth :: Window -> Effect Int
foreign import innerHeight :: Window -> Effect Int

foreign import scrollBy :: Int -> Int -> Window -> Effect Unit

foreign import open :: String -> String -> String -> Window -> Effect Window

open_ :: String -> String -> Window -> Effect Window
open_ url target window = open url target undefined window
