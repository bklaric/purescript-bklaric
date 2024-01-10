module Async.Promisey where

import Prelude

import Async (Async(..))
import Control.Monad.Cont (ContT(..))
import Control.Monad.Except (ExceptT(..))
import Data.Either (Either(..), either)
import Promisey (Promise, new, runPromise)

asyncToPromise :: forall left right. Async left right -> Promise left right
asyncToPromise (Async (ExceptT (ContT callback))) = new \resolve' reject' ->
    callback $ either reject' resolve'

promiseToAsync :: forall left right. Promise left right -> Async left right
promiseToAsync promise =
    Async (ExceptT (ContT \continuation ->
        promise
        # runPromise
            (\rejected -> continuation $ Left rejected)
            (\fulfilled -> continuation $ Right fulfilled)
    ))
