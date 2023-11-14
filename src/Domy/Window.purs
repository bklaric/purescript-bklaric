module Domy.Window where

import Prelude

import Domy.Class.EventTarget (class EventTarget, addEventListenerDefault, dispatchEventDefault, removeEventListenerDefault)
import Domy.Document (Document)
import Domy.Location (Location)
import Effect (Effect)
import Undefined (undefined)

foreign import data Window :: Type

instance eventTargetWindow :: EventTarget Window where
    addEventListener = addEventListenerDefault
    removeEventListener = removeEventListenerDefault
    dispatchEvent = dispatchEventDefault

foreign import document :: Window -> Effect Document

foreign import location :: Window -> Effect Location

foreign import innerWidth :: Window -> Effect Int
foreign import innerHeight :: Window -> Effect Int

foreign import scrollBy :: Int -> Int -> Window -> Effect Unit

foreign import open :: String -> String -> String -> Window -> Effect Window

open_ :: String -> String -> Window -> Effect Window
open_ url target window = open url target undefined window
