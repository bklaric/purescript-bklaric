module JavaScript.Node.Http.ServerResponse
    ( ServerResponse
    , addTrailers
    , close
    , defaultSetTimeout
    , error
    , finish
    , finished
    , getHeader
    , getHeaderNames
    , getHeaders
    , getSendDate
    , getStatusCode
    , getStatusMessage
    , hasHeader
    , headersSent
    , removeHeader
    , setHeader
    , setHeader'
    , setSendDate
    , setStatusCode
    , setStatusMessage
    , writeContinue
    , writeHead
    , writeHead_
    , writeHead_'
    , writeHead__
    )
    where

import Prelude

import Data.Nullable (Nullable)
import Effect (Effect)
import Foreign (Foreign, unsafeToForeign)
import JavaScript.Node.Errors (Error)
import JavaScript.Node.Events.Event (Event(..))
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Events.EventEmitter as EventEmitter
import JavaScript.Node.Stream.Writable (class Writable)
import JavaScript.Node.Stream.Writable as Writable
import Undefined (undefined)
import Unsafe.Coerce (unsafeCoerce)

foreign import data ServerResponse :: Type

instance EventEmitter ServerResponse where
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

instance Writable ServerResponse where
    writableHighWaterMark   = Writable.defaultWritableHighWaterMark
    writableLength          = Writable.defaultWritableLength
    cork                    = Writable.defaultCork
    uncork                  = Writable.defaultUncork
    write                   = Writable.defaultWrite
    end                     = Writable.defaultEnd
    destroy                 = Writable.defaultDestroy

foreign import addTrailers ::
    Foreign -> ServerResponse -> Effect Unit

foreign import finished ::
    ServerResponse -> Effect Boolean

foreign import getHeader ::
    String -> ServerResponse -> Effect String

foreign import getHeaderNames ::
    ServerResponse -> Effect (Array String)

foreign import getHeaders ::
    ServerResponse -> Effect Foreign

foreign import hasHeader ::
    String -> ServerResponse -> Effect Boolean

foreign import headersSent ::
    ServerResponse -> Effect Boolean

foreign import removeHeader ::
    String -> ServerResponse -> Effect Unit

foreign import getSendDate ::
    ServerResponse -> Effect Boolean

foreign import setSendDate ::
    Boolean -> ServerResponse -> Effect Unit

foreign import setHeaderImpl ::
    String -> Foreign -> ServerResponse -> Effect Unit

setHeader :: String -> String -> ServerResponse -> Effect Unit
setHeader name value response = setHeaderImpl name (unsafeToForeign value) response

setHeader' :: String -> Array String -> ServerResponse -> Effect Unit
setHeader' name values response = setHeaderImpl name (unsafeToForeign values) response

foreign import defaultSetTimeout ::
    Int -> Effect Unit -> ServerResponse -> Effect ServerResponse

foreign import getStatusCode ::
    ServerResponse -> Effect Int

foreign import setStatusCode ::
    Int -> ServerResponse -> Effect Unit

foreign import getStatusMessage ::
    ServerResponse -> Effect (Nullable String)

foreign import setStatusMessage ::
    String -> ServerResponse -> Effect Unit

foreign import writeContinue ::
    ServerResponse -> Effect Unit

foreign import writeHead ::
    Int -> String -> Foreign -> ServerResponse -> Effect Unit

writeHead_ :: Int -> Foreign -> ServerResponse -> Effect Unit
writeHead_ statusCode headers =
    writeHead statusCode (unsafeCoerce headers) undefined

writeHead_' :: Int -> String -> ServerResponse -> Effect Unit
writeHead_' statusCode statusMessage =
    writeHead statusCode statusMessage undefined

writeHead__ :: Int -> ServerResponse -> Effect Unit
writeHead__ statusCode =
    writeHead statusCode undefined undefined

error :: Event ServerResponse (Error -> Effect Unit)
error = Event "error"

close :: Event ServerResponse (Effect Unit)
close = Event "close"

finish :: Event ServerResponse (Effect Unit)
finish = Event "finish"
