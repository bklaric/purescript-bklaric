module Node.Stream.Readable
    ( class Readable
    , readableHighWaterMark
    , readableLength
    , isPaused
    , pause
    , read
    , resume
    , pipe
    , unpipe
    , setEncoding
    , unshift
    , destroy
    , defaultReadableHighWaterMark
    , defaultReadableLength
    , defaultIsPaused
    , defaultPause
    , defaultRead
    , defaultResume
    , defaultPipe
    , defaultUnpipe
    , defaultSetEncoding
    , defaultUnshift
    , defaultDestroy
    , pipe_
    , unpipe_
    ) where

import Prelude

import Data.Maybe (Maybe)
import Data.Nullable (Nullable, toMaybe)
import Effect (Effect)
import Foreign (Foreign)
import Node.Encoding (Encoding, toNodeString)
import Node.Errors (Error)
import Node.Events.EventEmitter (class EventEmitter)
import Node.Events.EventEmitter as EE
import Node.Stream.Writable (class Writable)
import Node.Stream.Writable as W
import Undefined (undefined)

class EventEmitter readable <= Readable readable where
    readableHighWaterMark :: readable -> Effect Int
    readableLength :: readable -> Effect Int
    isPaused :: readable -> Effect Boolean
    pause :: readable -> Effect readable
    read :: Int -> readable -> Effect (Maybe Foreign)
    resume :: readable -> Effect readable
    pipe :: forall writable. Writable writable =>
        writable -> Boolean -> readable -> Effect writable
    unpipe :: forall writable. Writable writable =>
        writable -> readable -> Effect Unit
    setEncoding :: Encoding -> readable -> Effect readable
    unshift :: Foreign -> readable -> Effect Unit
    destroy :: Error -> readable -> Effect readable

foreign import defaultReadableHighWaterMark :: forall readable. readable -> Effect Int

foreign import defaultReadableLength :: forall readable. readable -> Effect Int

foreign import defaultIsPaused :: forall readable. readable -> Effect Boolean

foreign import defaultPause :: forall readable. readable -> Effect readable

foreign import defaultReadImpl :: forall readable. Int -> readable -> Effect (Nullable Foreign)

defaultRead :: forall readable. Int -> readable -> Effect (Maybe Foreign)
defaultRead size readable = defaultReadImpl size readable <#> toMaybe

foreign import defaultResume :: forall readable. readable -> Effect readable

foreign import defaultPipe :: forall readable writable. writable -> Boolean -> readable -> Effect writable

foreign import defaultUnpipe :: forall readable writable. writable -> readable -> Effect Unit

foreign import defaultSetEncodingImpl :: forall readable.
    String -> readable -> Effect readable

defaultSetEncoding :: forall readable. Encoding -> readable -> Effect readable
defaultSetEncoding encoding readable =
    defaultSetEncodingImpl (toNodeString encoding) readable

foreign import defaultUnshift :: forall readable. Foreign -> readable -> Effect Unit

foreign import defaultDestroy :: forall readable. Error -> readable -> Effect readable

pipe_ :: forall readable writable. Readable readable => Writable writable =>
    writable -> readable -> Effect writable
pipe_ writable readable = pipe writable true readable

-- Flipping the typechecker off.
data UndefinedWritable

instance EventEmitter UndefinedWritable where
    on = EE.defaultOn
    once = EE.defaultOnce
    prependListener = EE.defaultPrependListener
    prependOnceListener = EE.defaultPrependOnceListener
    removeListener = EE.defaultRemoveListener
    removeAllListeners = EE.defaultRemoveAllListeners
    emit = EE.defaultEmit
    listeners = EE.defaultListeners
    listenerCount = EE.defaultListenerCount
    getMaxListeners = EE.defaultGetMaxListeners
    setMaxListeners = EE.defaultSetMaxListeners
    eventNames = EE.defaultEventNames

instance Writable UndefinedWritable where
    writableHighWaterMark = W.defaultWritableHighWaterMark
    writableLength = W.defaultWritableLength
    cork = W.defaultCork
    uncork = W.defaultUncork
    write = W.defaultWrite
    end = W.defaultEnd
    destroy = W.defaultDestroy

unpipe_ :: forall readable. Readable readable => readable -> Effect Unit
unpipe_ readable = unpipe (undefined :: UndefinedWritable) readable
