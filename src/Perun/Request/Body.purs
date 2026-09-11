module Perun.Request.Body
    ( Body
    , fromRequest
    , readBuffers
    , collectBuffers
    , readAsUtf8
    ) where

import Prelude

import Effect (Effect)
import JavaScript.Node.Buffer (Buffer, concat_, toString___)
import JavaScript.Node.Events.EventEmitter (class EventEmitter)
import JavaScript.Node.Http.IncomingMessage (IncomingMessage)
import JavaScript.Node.Stream.Readable (class Readable)
import JavaScript.Node.Stream.Readable.Events (collectDataEvents, readDataEvents)
import Unsafe.Coerce (unsafeCoerce)

newtype Body = Body IncomingMessage

derive newtype instance EventEmitter Body

derive newtype instance Readable Body

fromRequest :: IncomingMessage -> Body
fromRequest = Body

readBuffers :: (Buffer -> Effect Unit) -> Effect Unit -> Body -> Effect Body
readBuffers dataListener endListener body =
    body # readDataEvents (unsafeCoerce >>> dataListener) endListener

collectBuffers :: (Buffer -> Effect Unit) -> Body -> Effect Body
collectBuffers callback body =
    body # collectDataEvents (map unsafeCoerce >>> concat_ >=> callback)

readAsUtf8 :: (String -> Effect Unit) -> Body -> Effect Body
readAsUtf8 callback body = body # collectBuffers (toString___ >=> callback)
