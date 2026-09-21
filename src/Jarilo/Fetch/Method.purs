module Jarilo.Fetch.Method (class FetchMethod, fetchMethod) where

import Prelude

import Data.HTTP.Method as Http
import Jarilo.Types (Delete, Get, Head, Method, Options, Patch, Post, Put)
import Type.Proxy (Proxy)

class FetchMethod (method :: Method) where
    fetchMethod :: Proxy method -> String

instance FetchMethod Options where
    fetchMethod _ = show Http.OPTIONS

instance FetchMethod Head where
    fetchMethod _ = show Http.HEAD

instance FetchMethod Get where
    fetchMethod _ = show Http.GET

instance FetchMethod Post where
    fetchMethod _ = show Http.POST

instance FetchMethod Put where
    fetchMethod _ = show Http.PUT

instance FetchMethod Patch where
    fetchMethod _ = show Http.PATCH

instance FetchMethod Delete where
    fetchMethod _ = show Http.DELETE
