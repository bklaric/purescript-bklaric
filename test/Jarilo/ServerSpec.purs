-- | The server, driven with the raw fetch: most of what it has to answer is
-- | what Jarilo's own fetch never sends.
module Test.Jarilo.ServerSpec (spec) where

import Prelude

import Data.Array (last)
import Data.Foldable (for_)
import Data.Maybe (Maybe(..))
import Effect.Aff (Aff)
import Effect.Class (liftEffect)
import Effect.Ref (Ref)
import Effect.Ref as Ref
import Foreign.Object as Object
import Jarilo.Serve (Rejection)
import JavaScript.Promise.Aff (promiseToAff)
import JavaScript.Web.Fetch.Fetch as Fetch
import JavaScript.Web.Fetch.Headers as Headers
import JavaScript.Web.Fetch.RequestInit (RequestInit)
import JavaScript.Web.Fetch.Response (headers, status, text)
import Test.Jarilo.Routes (ThingBody, origin)
import Test.Spec (Spec, describe, it)
import Test.Spec.Assertions (shouldEqual)
import Unsafe.Coerce (unsafeCoerce)
import Untagged.Castable (class Castable)
import Untagged.Union (UndefinedOr)
import Yoga.JSON (readJSON_)

type Answer =
    { status :: Int
    , allow :: Maybe String
    , contentType :: Maybe String
    , body :: String
    }

-- The Error of JavaScript.Error and the Error of Aff are the same JS value.
request :: ∀ options. Castable options (UndefinedOr RequestInit) =>
    String -> options -> Aff Answer
request path options = promiseToAff unsafeCoerce do
    response <- Fetch.fetch (origin <> path) options
    body <- text response
    allow <- liftEffect $ Headers.get "allow" (headers response)
    contentType <- liftEffect $ Headers.get "content-type" (headers response)
    pure { status: status response, allow, contentType, body }

get :: String -> Aff Answer
get path = request path {}

thing :: Answer -> Maybe ThingBody
thing = _.body >>> readJSON_

lastRejection :: Ref (Array Rejection) -> Aff (Maybe Rejection)
lastRejection rejections = Ref.read rejections <#> last # liftEffect

spec :: Ref (Array Rejection) -> Spec Unit
spec rejections = describe "Jarilo.Serve" do
    describe "a request a route takes" do
        it "is answered by its handler, labelled as JSON" do
            answer <- get "/things/a?count=1"
            answer.status `shouldEqual` 200
            answer.contentType `shouldEqual` Just "application/json"
            thing answer `shouldEqual` Just { name: "a", count: 1, tags: [], session: "" }

        it "is answered with a status its handler chose" do
            answer <- get "/things/missing?count=1"
            answer.status `shouldEqual` 404

        it "has its path and query decoded" do
            answer <- get "/things/Valorant%54ester?count=1&tag=Europe%2FZagreb&tag=%C3%A9"
            (thing answer <#> _.name) `shouldEqual` Just "ValorantTester"
            (thing answer <#> _.tags) `shouldEqual` Just [ "Europe/Zagreb", "é" ]

        it "keeps a cookie value that holds =" do
            answer <- request "/things/a?count=1"
                { headers: Object.singleton "Cookie" "other=1; session=abc==" }
            (thing answer <#> _.session) `shouldEqual` Just "abc=="

    describe "a request no route takes" do
        it "is answered 404 when no route has its path" do
            answer <- get "/nosuchroute"
            answer.status `shouldEqual` 404

        it "is answered 405 with the methods its path takes" do
            answer <- request "/things/a" { method: "PUT" }
            answer.status `shouldEqual` 405
            answer.allow `shouldEqual` Just "GET, DELETE"

        it "is reported with why it was rejected" do
            _ <- request "/things/a" { method: "PUT" }
            rejection <- lastRejection rejections
            rejection `shouldEqual` Just
                { method: "PUT"
                , url: "/things/a"
                , statusCode: 405
                , reason: "This path takes only GET, DELETE."
                }

    describe "a malformed request to a route" do
        it "is answered 400 for a body that isn't JSON" do
            answer <- request "/echo" { method: "POST", body: "not json" }
            answer.status `shouldEqual` 400
            rejection <- lastRejection rejections
            (rejection <#> _.statusCode) `shouldEqual` Just 400

        it "is answered 400 for a query value that doesn't parse" do
            answer <- get "/things/a?count=abc"
            answer.status `shouldEqual` 400

        it "is answered 400 for a missing query parameter" do
            answer <- get "/things/a"
            answer.status `shouldEqual` 400

    -- The uri package throws on these while decoding, which took the process
    -- down before the server checked them.
    describe "an escape that isn't UTF-8" do
        for_ [ "/things/%C3?count=1", "/things/a?count=%C3", "/things/a?%C3=1&count=1" ] \path ->
            it ("is answered 400 in " <> path) do
                answer <- get path
                answer.status `shouldEqual` 400

        it "leaves the server up" do
            answer <- get "/things/a?count=1"
            answer.status `shouldEqual` 200
