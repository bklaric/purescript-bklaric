module JavaScript.Npm.Alwan where

import Prelude

import Effect (Effect)
import JavaScript.Web.DOM.Class (class HtmlElement)
import JavaScript.Web.DOM.HtmlElements.HtmlElement (HtmlElement, toHtmlElement)
import Literals (StringLit)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

-- https://www.npmjs.com/package/alwan

foreign import data Alwan :: Type

type Options =
    { color :: UndefinedOr String
    , format :: UndefinedOr String
    , opacity :: UndefinedOr Boolean
    , swatches :: UndefinedOr (Array String)
    }

foreign import _new :: String |+| HtmlElement -> UndefinedOr Options -> Effect Alwan

newFromSelector :: forall options. Castable options (UndefinedOr Options) =>
    String -> options -> Effect Alwan
newFromSelector (selector :: String) options = _new (cast selector) (cast options)

newFromHTMLElement :: forall htmlElement options. HtmlElement htmlElement => Castable options (UndefinedOr Options) =>
    htmlElement -> options -> Effect Alwan
newFromHTMLElement htmlElement options = _new (cast $ toHtmlElement htmlElement) (cast options)

type EventType = StringLit "open" |+| StringLit "close" |+| StringLit "change" |+| StringLit "color"

type EventObject = {hex :: String}

foreign import _on :: EventType -> (EventObject -> Effect Unit) -> Alwan -> Effect Unit

on :: forall eventType. Castable eventType EventType =>
    eventType -> (EventObject -> Effect Unit) -> Alwan -> Effect Unit
on eventType listener alwan = _on (cast eventType) listener alwan
