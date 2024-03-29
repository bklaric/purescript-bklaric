module JavaScript.Node.Http.IncomingMessage where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign (Foreign)
import Foreign.Object (Object)
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import JavaScript.Node.Stream.Readable (class Readable)
import JavaScript.Node.Stream.Readable as Readable
import Undefined (undefined)

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

foreign import trailers :: IncomingMessage -> Effect Foreign

foreign import setTimeout :: Int -> Effect Unit -> IncomingMessage -> Effect IncomingMessage

foreign import destroy :: Error -> IncomingMessage -> Effect Unit

destroy_ :: IncomingMessage -> Effect Unit
destroy_ = destroy undefined

foreign import methodImpl :: IncomingMessage -> Nullable String

method :: IncomingMessage -> Maybe String
method message = methodImpl message # toMaybe

foreign import urlImpl :: IncomingMessage -> Nullable String

url :: IncomingMessage -> Maybe String
url message = urlImpl message # toMaybe

error :: Event IncomingMessage (Error -> Effect Unit)
error = Event "error"

aborted :: Event IncomingMessage (Effect Unit)
aborted = Event "aborted"

close :: Event IncomingMessage (Effect Unit)
close = Event "close"
