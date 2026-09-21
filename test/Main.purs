module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Ref as Ref
import Test.Jarilo.FetchSpec as FetchSpec
import Test.Jarilo.Routes as Routes
import Test.Jarilo.ServerSpec as ServerSpec
import Test.Spec.Reporter (consoleReporter)
import Test.Spec.Runner.Node (runSpecAndExitProcess)

main :: Effect Unit
main = do
    rejections <- Ref.new []
    Routes.serveRoutes rejections
    runSpecAndExitProcess [ consoleReporter ] do
        ServerSpec.spec rejections
        FetchSpec.spec
