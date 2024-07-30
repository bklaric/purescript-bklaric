module JavaScript.Web.DOM.Element where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import JavaScript.Web.DOM.Class.Element (class Element)
import JavaScript.Web.DOM.Class.Node (class Node)
import JavaScript.Web.DOM.DomRect (DomRect)
import JavaScript.Web.DOM.DomTokenList (DomTokenList)
import JavaScript.Web.DOM.ElementType (Element)
import JavaScript.Web.DOM.HtmlCollection (HtmlCollection)
import JavaScript.Web.DOM.Node (Node)
import JavaScript.Web.DOM.NodeList (NodeList)
import JavaScript.Web.DOM.Utils (toArray)
import Literals (StringLit)
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|))

toElement :: forall element. Element element => element -> Element
toElement = unsafeCoerce

foreign import _getBoundingClientRect :: forall element. element -> Effect DomRect
foreign import _getAttribute :: forall element. String -> element -> Effect (Nullable String)
foreign import _removeAttribute :: forall element. String -> element -> Effect Unit
foreign import _innerHtml :: forall element. element -> Effect String
foreign import _setInnerHtml :: forall element. String -> element -> Effect Unit
foreign import _outerHtml :: forall element. element -> Effect String
foreign import _setOuterHtml :: forall element. String -> element -> Effect Unit
foreign import _insertAdjacentHTML :: forall element. StringLit "beforebegin" |+| StringLit "afterbegin" |+| StringLit "beforeend" |+| StringLit "afterend" -> String -> element -> Effect Unit
foreign import _replaceWith :: forall node element. node -> element -> Effect Unit
foreign import _scrollWidth :: forall element. element -> Effect Int
foreign import _scrollHeight :: forall element. element -> Effect Int
foreign import _scrollTop :: forall element. element -> Effect Int
foreign import _scrollLeft :: forall element. element -> Effect Int
foreign import _setScrollTop :: forall element. Int -> element -> Effect Unit
foreign import _setScrollLeft :: forall element. Int -> element -> Effect Unit
foreign import _scrollBy :: forall element. Int -> Int -> element -> Effect Unit
foreign import _querySelector :: forall element. String -> element -> Effect (Nullable Element)
foreign import _querySelectorAll :: forall element. String -> element -> Effect NodeList
foreign import _id :: forall element. element -> Effect String
foreign import _setId :: forall element. String -> element -> Effect Unit
foreign import _className :: forall element. element -> Effect String
foreign import _setClassName :: forall element. String -> element -> Effect Unit
foreign import _classList :: forall element. element -> Effect DomTokenList
foreign import _remove :: forall element. element -> Effect Unit
foreign import _children :: forall element. element -> Effect HtmlCollection

getBoundingClientRect :: forall element. Element element => element -> Effect DomRect
getBoundingClientRect = _getBoundingClientRect

getAttribute :: forall element. Element element => String -> element -> Effect (Maybe String)
getAttribute attribute element = _getAttribute attribute element <#> toMaybe

removeAttribute :: forall element. Element element => String -> element -> Effect Unit
removeAttribute = _removeAttribute

innerHtml :: forall element. Element element => element -> Effect String
innerHtml = _innerHtml

setInnerHtml :: forall element. Element element => String -> element -> Effect Unit
setInnerHtml = _setInnerHtml

outerHtml :: forall element. Element element => element -> Effect String
outerHtml = _outerHtml

setOuterHtml :: forall element. Element element => String -> element -> Effect Unit
setOuterHtml = _setOuterHtml

insertAdjacentHTML :: forall element position. Castable position (StringLit "beforebegin" |+| StringLit "afterbegin" |+| StringLit "beforeend" |+| StringLit "afterend") =>
    position -> String -> element -> Effect Unit
insertAdjacentHTML position text element = _insertAdjacentHTML (cast position) text element

replaceWith :: forall node element. Node node => Element element => node -> element -> Effect Unit
replaceWith = _replaceWith

scrollWidth :: forall element. Element element => element -> Effect Int
scrollWidth = _scrollWidth

scrollHeight :: forall element. Element element => element -> Effect Int
scrollHeight = _scrollHeight

scrollTop :: forall element. Element element => element -> Effect Int
scrollTop = _scrollTop

scrollLeft :: forall element. Element element => element -> Effect Int
scrollLeft = _scrollLeft

setScrollTop :: forall element. Element element => Int -> element -> Effect Unit
setScrollTop = _setScrollTop

setScrollLeft :: forall element. Element element => Int -> element -> Effect Unit
setScrollLeft = _setScrollLeft

scrollBy :: forall element. Element element => Int -> Int -> element -> Effect Unit
scrollBy = _scrollBy

querySelector :: forall element. Element element => String -> element -> Effect (Maybe Element)
querySelector selector element = _querySelector selector element <#> toMaybe

querySelectorAll :: forall element. Element element => String -> element -> Effect NodeList
querySelectorAll = _querySelectorAll

querySelectorAll' :: forall element. Element element => String -> element -> Effect (Array Node)
querySelectorAll' selector element = querySelectorAll selector element >>= toArray

id :: forall element. Element element => element -> Effect String
id = _id

setId :: forall element. Element element => String -> element -> Effect Unit
setId = _setId

className :: forall element. Element element => element -> Effect String
className = _className

setClassName :: forall element. Element element => String -> element -> Effect Unit
setClassName = _setClassName

classList :: forall element. Element element => element -> Effect DomTokenList
classList = _classList

classList' :: forall element. Element element => element -> Effect (Array String)
classList' element = element # classList >>= toArray

remove :: forall element. Element element => element -> Effect Unit
remove = _remove

children :: forall element. Element element => element -> Effect HtmlCollection
children = _children

children' :: forall element. Element element => element -> Effect (Array Element)
children' element = element # children >>= toArray
