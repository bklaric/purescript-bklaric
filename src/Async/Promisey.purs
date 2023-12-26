module Async.Promisey where

import Prelude

import Async (Async(..))
import Control.Monad.Cont (ContT(..))
import Control.Monad.Except (ExceptT(..))
import Data.Either (Either(..), either)
import Effect (Effect)
import Promisey (Promise, new, resolve, thenOrCatch)

asyncToPromise :: forall left right. Async left right -> Effect (Promise left right)
asyncToPromise (Async (ExceptT (ContT callback))) = new \resolve' reject' ->
    callback $ either reject' resolve'

promiseToAsync :: forall left right. Promise left right -> Async left right
promiseToAsync promise =
    Async (ExceptT (ContT \continuation ->
        promise
        # thenOrCatch
            (\fulfilled -> do
                result <- continuation $ Right fulfilled
                resolve result
            )
            (\rejected -> do
                result <- continuation $ Left rejected
                resolve result
            )
        # void
    ))
