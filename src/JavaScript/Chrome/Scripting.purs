module JavaScript.Chrome.Scripting (ExecutionWorld, InjectionTarget, ScriptInjection, executeScript, insertCSS) where

import Prelude

import Data.Nullable (Nullable)
import Foreign (Foreign)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Literals (StringLit)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/scripting

type ExecutionWorld = StringLit "ISOLATED" |+| StringLit "MAIN"

type InjectionTarget
    =   {tabId :: Int, allFrames :: UndefinedOr Boolean}
    |+| {tabId :: Int, frameIds :: UndefinedOr (Array Int)}

type ScriptInjection
    =   {injectImmediately :: UndefinedOr Boolean, target :: InjectionTarget, words :: UndefinedOr ExecutionWorld, files :: Array String}
    |+| {injectImmediately :: UndefinedOr Boolean, target :: InjectionTarget, words :: UndefinedOr ExecutionWorld, args :: UndefinedOr (Array Foreign), func :: Foreign}

type InjectionResult = {frameId :: Int, result :: Nullable Foreign, error :: Nullable Foreign}

foreign import _executeScript :: ScriptInjection -> Promise Error (Array InjectionResult)

executeScript :: forall injection. Castable injection ScriptInjection =>
    injection -> Promise Error (Array InjectionResult)
executeScript = _executeScript <<< cast

foreign import _insertCSS :: {css :: UndefinedOr String, files :: UndefinedOr (Array String), origin :: UndefinedOr String, target :: InjectionTarget} -> Promise Error Unit

insertCSS :: forall details.
    Castable details
    { css :: UndefinedOr String
    , files :: UndefinedOr (Array String)
    , origin :: UndefinedOr String
    , target :: InjectionTarget
    } =>
    details -> Promise Error Unit
insertCSS = _insertCSS <<< cast
