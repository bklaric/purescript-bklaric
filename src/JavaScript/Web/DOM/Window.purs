module JavaScript.Web.DOM.Window where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class (class Element, class EventTarget)
import JavaScript.Web.DOM.Selection (Selection)
import JavaScript.Web.DOM.CssStyleDeclaration (CssStyleDeclaration)
import JavaScript.Web.DOM.Document (Document)
import JavaScript.Web.DOM.Location (Location)
import JavaScript.Web.DOM.Navigator (Navigator)
import JavaScript.Web.WebStorage.Storage (Storage)
import Literals.Undefined (undefined)
import Untagged.Castable (cast)
import Untagged.Union (UndefinedOr)

foreign import data Window :: Type

instance EventTarget Window

foreign import parent :: Window -> Effect Window
foreign import top :: Window -> Effect Window

foreign import document :: Window -> Effect Document
foreign import location :: Window -> Effect Location
foreign import navigator :: Window -> Effect Navigator
foreign import localStorage :: Window -> Effect Storage

foreign import innerWidth :: Window -> Effect Int
foreign import innerHeight :: Window -> Effect Int

foreign import devicePixelRatio :: Window -> Effect Number

foreign import _getSelection :: Window -> Effect (Nullable Selection)

-- | `Nothing` only for a window with no document to select in, such as a hidden iframe's in Firefox.
getSelection :: Window -> Effect (Maybe Selection)
getSelection window = _getSelection window <#> toMaybe

foreign import scrollBy :: Int -> Int -> Window -> Effect Unit

foreign import open :: String -> String -> UndefinedOr String -> Window -> Effect Window

open_ :: String -> String -> Window -> Effect Window
open_ url target window = open url target (cast undefined) window

foreign import close :: Window -> Effect Unit

foreign import _getComputedStyle :: forall element. element -> UndefinedOr String -> Window -> Effect CssStyleDeclaration

getComputedStyle :: forall element. Element element => element -> String -> Window -> Effect CssStyleDeclaration
getComputedStyle element pseudoElement window = _getComputedStyle element (cast pseudoElement) window

getComputedStyle_ :: forall element. Element element => element -> Window -> Effect CssStyleDeclaration
getComputedStyle_ element window = _getComputedStyle element (cast undefined) window

foreign import requestAnimationFrame :: (Number -> Effect Unit) -> Window -> Effect Unit
