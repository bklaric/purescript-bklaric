module Jarilo.Router.Method (class MethodRouter, methodRouter) where

import Data.Either (Either(..))
import Data.HTTP.Method (Method(..)) as HM
import Jarilo.Server.Request (HttpMethod)
import Jarilo.Types (Delete, Get, Head, Method, Options, Patch, Post, Put)
import Type.Proxy (Proxy)

class MethodRouter (method :: Method) where
    methodRouter :: Proxy method -> HttpMethod

instance MethodRouter Options where
    methodRouter _ = Left HM.OPTIONS

instance MethodRouter Head where
    methodRouter _ = Left HM.HEAD

instance MethodRouter Get where
    methodRouter _ = Left HM.GET

instance MethodRouter Post where
    methodRouter _ = Left HM.POST

instance MethodRouter Put where
    methodRouter _ = Left HM.PUT

instance MethodRouter Patch where
    methodRouter _ = Left HM.PATCH

instance MethodRouter Delete where
    methodRouter _ = Left HM.DELETE
