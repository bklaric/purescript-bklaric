module JavaScript.Chrome.Scripting (ExecutionWorld, InjectionTarget, ScriptInjection, executeScript) where

import Prelude

import Data.Nullable (Nullable)
import Foreign (Foreign)
import JavaScript.Error (Error)
import Literals (StringLit)
import Promisey (Promise)
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

executeScript :: forall injection. Castable injection ScriptInjection
    => injection -> Promise Error (Array InjectionResult)
executeScript = _executeScript <<< cast
