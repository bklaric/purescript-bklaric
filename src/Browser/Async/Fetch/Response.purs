module Browser.Async.Fetch.Response
    ( module Browser.Fetch.Response
    , text
    , json
    , clone
    ) where

import Prelude

import Async (Async, fromEffect, fromEffectCont, fromEitherCont)
import Browser.Fetch.Response (Response, status)
import Browser.Fetch.Response as FRes
import JavaScript.Error (Error)
import Foreign (Foreign)

text :: ∀ left. Response -> Async left String
text = flip FRes.text >>> fromEffectCont

json :: Response -> Async Error Foreign
json = flip FRes.json >>> fromEitherCont

clone :: forall left. Response -> Async left Response
clone = FRes.clone >>> fromEffect
