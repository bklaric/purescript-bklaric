module JavaScript.Node.Http.IncomingMessage where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Data.String as String
import Effect (Effect)
import Foreign (Foreign)
import Foreign.Object (Object)
import Foreign.Object as Object
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import JavaScript.Node.Stream.Readable (class Readable)
import JavaScript.Node.Stream.Readable as Readable
import Undefined (undefined)
import Yoga.JSON as Json

foreign import data IncomingMessage :: Type

instance EventEmitter IncomingMessage where
    on                  = EventEmitter.defaultOn
    once                = EventEmitter.defaultOnce
    prependListener     = EventEmitter.defaultPrependListener
    prependOnceListener = EventEmitter.defaultPrependOnceListener
    removeListener      = EventEmitter.defaultRemoveListener
    removeAllListeners  = EventEmitter.defaultRemoveAllListeners
    emit                = EventEmitter.defaultEmit
    listeners           = EventEmitter.defaultListeners
    listenerCount       = EventEmitter.defaultListenerCount
    getMaxListeners     = EventEmitter.defaultGetMaxListeners
    setMaxListeners     = EventEmitter.defaultSetMaxListeners
    eventNames          = EventEmitter.defaultEventNames

instance Readable IncomingMessage where
    readableHighWaterMark = Readable.defaultReadableHighWaterMark
    readableLength        = Readable.defaultReadableLength
    isPaused              = Readable.defaultIsPaused
    pause                 = Readable.defaultPause
    read                  = Readable.defaultRead
    resume                = Readable.defaultResume
    pipe                  = Readable.defaultPipe
    unpipe                = Readable.defaultUnpipe
    setEncoding           = Readable.defaultSetEncoding
    unshift               = Readable.defaultUnshift
    destroy               = Readable.defaultDestroy

foreign import httpVersion :: IncomingMessage -> String

foreign import rawHeaders :: IncomingMessage -> Array String

foreign import headers :: IncomingMessage -> Object Foreign

-- One header's value, looked up by name. Node lowercases every key in `headers`,
-- so the name is lowercased too rather than leaving each caller to remember that.
-- Nothing for a header that was not sent, and for the array-valued ones (set-cookie)
-- that are not a single string.
header :: String -> IncomingMessage -> Maybe String
header name message = headers message # Object.lookup (String.toLower name) >>= Json.read_

foreign import headersDistinct :: IncomingMessage -> Object (Array String)

-- | `Effect`, where `headers` above is pure: Node only populates the trailing
-- | headers once the message has fully arrived, so this reads `{}` until the
-- | stream's `end` event and a different value after it.
foreign import trailers :: IncomingMessage -> Effect Foreign

foreign import setTimeout :: Int -> Effect Unit -> IncomingMessage -> Effect IncomingMessage

foreign import destroy :: Error -> IncomingMessage -> Effect Unit

destroy_ :: IncomingMessage -> Effect Unit
destroy_ = destroy undefined

foreign import _method :: IncomingMessage -> Nullable String

method :: IncomingMessage -> Maybe String
method message = _method message # toMaybe

foreign import _url :: IncomingMessage -> Nullable String

url :: IncomingMessage -> Maybe String
url message = _url message # toMaybe

error :: Event IncomingMessage (Error -> Effect Unit)
error = Event "error"

aborted :: Event IncomingMessage (Effect Unit)
aborted = Event "aborted"

close :: Event IncomingMessage (Effect Unit)
close = Event "close"
