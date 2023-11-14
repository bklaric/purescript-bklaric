module Node.Http.Server.Request where

import Node.Events.EventEmitter (class EventEmitter)
import Node.Events.EventEmitter as EventEmitter
import Node.Http.IncomingMessage (class IncomingMessage)
import Node.Http.IncomingMessage as IncomingMessage
import Node.Stream.Readable (class Readable)
import Node.Stream.Readable as Readable

foreign import data Request :: Type

instance EventEmitter Request where
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

instance Readable Request where
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

instance IncomingMessage Request where
    httpVersion = IncomingMessage.defaultHttpVersion
    rawHeaders  = IncomingMessage.defaultRawHeaders
    headers     = IncomingMessage.defaultHeaders
    trailers    = IncomingMessage.defaultTrailers
    setTimeout  = IncomingMessage.defaultSetTimeout
    destroy     = IncomingMessage.defaultDestroy

foreign import method :: Request -> String

foreign import url :: Request -> String
