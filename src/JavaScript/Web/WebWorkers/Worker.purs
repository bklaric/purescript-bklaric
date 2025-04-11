module JavaScript.Web.WebWorkers.Worker (Worker, new, new_, postMessage) where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Foreign (Foreign)
import JavaScript.Error (Error)
import JavaScript.Web.DOM.Class (class EventTarget)
import JavaScript.Web.URL.URL (URL)
import Literals.Undefined (undefined)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)
import ValidJson (class ValidJson)

-- https://developer.mozilla.org/en-US/docs/Web/API/Worker

foreign import data Worker :: Type

instance EventTarget Worker

foreign import _new
    :: (Error -> Either Error Worker)
    -> (Worker -> Either Error Worker)
    -> String |+| URL
    -> UndefinedOr Foreign
    -> Effect (Either Error Worker)

new :: forall url options.
    Castable url (String |+| URL) => Castable options (UndefinedOr Foreign) =>
    url -> options -> Effect (Either Error Worker)
new url options = _new Left Right (cast url) (cast options)

new_ :: forall url.
    Castable url (String |+| URL) =>
    url -> Effect (Either Error Worker)
new_ url = new url undefined

foreign import _postMessage :: forall message. message -> Worker -> Effect Unit

postMessage :: forall message. ValidJson message => message -> Worker -> Effect Unit
postMessage = _postMessage
