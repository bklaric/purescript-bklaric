-- | Jarilo's fetch against the routes Jarilo serves, and against routes the
-- | server doesn't have, which is how a client gets what it doesn't expect.
module Test.Jarilo.FetchSpec (spec) where

import Prelude

import Data.Char (fromCharCode)
import Data.Either (Either(..))
import Data.Maybe (fromMaybe)
import Data.String.CodeUnits (singleton)
import Data.Variant (match)
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Foreign.Object as Object
import Jarilo (type (/), type (&), type (==>), Capture, Get, Get_, Literal, Mandatory, Many, OkJson, Ok_)
import Jarilo.Fetch (FetchError(..), fetch)
import Jarilo.Fetch.Url (fetchUrl)
import JavaScript.Promise (Promise)
import JavaScript.Promise as Promise
import JavaScript.Promise.Aff (promiseToAff)
import JavaScript.Web.DOM.AbortController as AbortController
import Test.Jarilo.Routes (Echo, Thing, origin)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Type.Proxy (Proxy(..))

type ThingPath = Literal "things" / Capture "name" String

type ThingQuery = Mandatory "count" Int & Many "tag" String

-- Routes the server doesn't have as declared here.

type Missing = Get_ (Literal "nosuchroute") ==> Ok_

type WrongBody = Get ThingPath ThingQuery ==> OkJson { notThere :: Int }

-- FetchError has no Eq: what a spec compares is which error it was.
errorKind :: FetchError -> String
errorKind = case _ of
    NetworkError _ -> "NetworkError"
    Aborted -> "Aborted"
    UnexpectedStatus code -> "UnexpectedStatus " <> show code
    UnreadableBody code _ -> "UnreadableBody " <> show code
    UnencodableUrl _ -> "UnencodableUrl"

settle :: ∀ right. Promise FetchError right -> Aff (Either FetchError right)
settle promise = promise # Promise.alwaysRight Left Right # promiseToAff absurd

-- Which way the fetch went: what the spec reads from its response, or the
-- kind of error.
outcome :: ∀ right. (right -> String) -> Promise FetchError right -> Aff String
outcome read promise = settle promise <#> case _ of
    Left error -> errorKind error
    Right response -> read response

loneSurrogate :: String
loneSurrogate = fromCharCode 0xD800 # map singleton # fromMaybe ""

spec :: Spec Unit
spec = describe "Jarilo.Fetch" do
    describe "the URL" do
        it "has every segment, name and value encoded" do
            fetchUrl (Proxy :: _ ThingPath) (Proxy :: _ ThingQuery)
                { name: "a b#c/d" } { count: 1, tag: [ "x&y=z+", "é" ] }
                `shouldEqual` Right "/things/a%20b%23c%2Fd?count=1&tag=x%26y%3Dz%2B&tag=%C3%A9"

        it "has no stray separator for an empty Many" do
            fetchUrl (Proxy :: _ ThingPath) (Proxy :: _ ThingQuery)
                { name: "a" } { count: 1, tag: [] }
                `shouldEqual` Right "/things/a?count=1"

        it "fails on a value no URL can carry" do
            fetchUrl (Proxy :: _ ThingPath) (Proxy :: _ ThingQuery)
                { name: loneSurrogate } { count: 1, tag: [] }
                `shouldEqual` Left loneSurrogate

    describe "a route the server has" do
        it "arrives as the server decodes it" do
            result <- settle $ fetch (Proxy :: _ Thing)
                { name: "a b#c/d" } { count: 2, tag: [ "x&y=z+", "é" ] } unit origin {}
            case result of
                Right response -> response # match
                    { ok: \body -> do
                        body.name `shouldEqual` "a b#c/d"
                        body.tags `shouldEqual` [ "x&y=z+", "é" ]
                    , notFound: \_ -> "notFound" `shouldEqual` "ok"
                    }
                Left error -> errorKind error `shouldEqual` "ok"

        it "is answered with whichever response it declares" do
            fetch (Proxy :: _ Thing) { name: "missing" } { count: 1, tag: [] } unit origin {}
                # outcome (match { ok: const "ok", notFound: const "notFound" })
                >>= (_ `shouldEqual` "notFound")

        it "sends a JSON body labelled as JSON" do
            result <- settle $ fetch (Proxy :: _ Echo) {} {} { text: "hi" } origin {}
            (result <#> match { ok: _.contentType }) `shouldEqualRight` "application/json"

        it "sends the caller's headers beside the route's" do
            result <- settle $ fetch (Proxy :: _ Echo) {} {} { text: "hi" } origin
                { headers: Object.singleton "X-Probe" "1" }
            (result <#> match { ok: \body -> body.contentType <> " " <> body.probe })
                `shouldEqualRight` "application/json 1"

    describe "a fetch without a declared response" do
        it "fails on a status the route doesn't declare" do
            fetch (Proxy :: _ Missing) {} {} unit origin {}
                # outcome (const "ok") >>= (_ `shouldEqual` "UnexpectedStatus 404")

        it "fails on a body that isn't what the route declares" do
            fetch (Proxy :: _ WrongBody) { name: "a" } { count: 1, tag: [] } unit origin {}
                # outcome (const "ok") >>= (_ `shouldEqual` "UnreadableBody 200")

        it "fails when nothing answers" do
            fetch (Proxy :: _ Missing) {} {} unit "http://localhost:1" {}
                # outcome (const "ok") >>= (_ `shouldEqual` "NetworkError")

        it "fails on a value no URL can carry, without a request" do
            fetch (Proxy :: _ Thing) { name: loneSurrogate } { count: 1, tag: [] } unit origin {}
                # outcome (const "ok") >>= (_ `shouldEqual` "UnencodableUrl")

        -- A promise is cold, so it is shared to start the request before the
        -- abort rather than when the spec awaits it.
        it "fails as aborted when its signal aborts it in flight" do
            controller <- liftEffect AbortController.new
            inFlight <- liftEffect $ Promise.share $
                fetch (Proxy :: _ Thing) { name: "a" } { count: 1, tag: [] } unit origin
                    { signal: AbortController.signal controller }
            liftEffect $ AbortController.abort controller
            inFlight # outcome (const "ok") >>= (_ `shouldEqual` "Aborted")
    where
    shouldEqualRight :: Either FetchError String -> String -> Aff Unit
    shouldEqualRight result expected = case result of
        Right actual -> actual `shouldEqual` expected
        Left error -> errorKind error `shouldEqual` expected
