# purescript-bklaric

The PureScript library behind [TeamTavern](https://github.com/bklaric/team-tavern)
and my browser extensions: an HTTP router and client, an async type, validation,
and hand-written bindings to the browser, Node, Chrome extension APIs and a few
npm packages.

It isn't in the PureScript registry, and it makes no stability promise. Modules
change when the projects that use them need them to.

## What's in it

| Modules | What they are |
| --- | --- |
| `Jarilo` | Routes declared as types, served by a Node HTTP server and called from the browser through `fetch`, both derived from the same type |
| `Async`, `AsyncV` | `Async left right`, a continuation-based async computation with a typed error, and `AsyncV`, its accumulating counterpart over `Validated` |
| `Data.Validated` | `Validated invalid valid`, an applicative that collects every error instead of stopping at the first |
| `JavaScript.Web.*` | DOM, events, `fetch`, URL, clipboard, Web Crypto, Web Storage, workers, animations, SVG, files |
| `JavaScript.Node.*` | `http`, `net`, `fs`, streams, events, `crypto`, `zlib`, buffers, timers, process |
| `JavaScript.Chrome.*` | Extension APIs: tabs, windows, runtime, storage, scripting, menus, notifications, web requests and more |
| `JavaScript.Npm.*` | `pg`, the AWS SDK's S3 and SES v2 clients, SendGrid, fast-csv, ua-parser-js, Alwan |
| `JavaScript.Promise` | A typed `Promise left right` over native promises, used in place of `Aff` |
| `Bcrypt`, `Postmark` | Bindings to `bcrypt` and the Postmark client |
| `Wrapped`, `ValidJson`, `Yoga.JSON.Async` | Smart constructors that canonicalize and validate input, a constraint for types that survive a JSON round trip, and JSON decoding inside `Async` |

## Jarilo

A route is a type. This one takes a path parameter and answers with JSON or a
`404`:

```purescript
type ViewPost =
    Get_ (Literal "games" / Capture "handle" String / Literal "posts" / Capture "id" Int)
    ==> OkJson OkContent ! NotFound_ ! Internal_
```

Routes are joined under names, and the server takes a record with a handler for
each. The compiler works out each handler's arguments and the responses it may
return from the route:

```purescript
type AllRoutes
    =   "viewPost"     : ViewPost
    <|> "startSession" : StartSession

serve (Proxy :: _ AllRoutes) options
    { viewPost: \{ path } -> viewPost path.handle path.id
    , startSession: \{ cookies, body } -> startSession cookies body
    }
```

The client calls the same type, and gets back a `Variant` with a case per
declared response:

```purescript
fetch (Proxy :: _ ViewPost) { handle: "valorant", id: 42 } {} unit "/api" {}
```

[One route type, two sides](https://dev.to/bklaric/one-route-type-two-sides-a-purescript-client-and-server-that-share-their-http-api-374l)
walks through how this works in TeamTavern, which serves its whole API this way.

## Using it

Add it to your `spago.yaml` as an extra package, together with the two forks it
builds against:

```yaml
workspace:
  extraPackages:
    bklaric:
      git: https://github.com/bklaric/purescript-bklaric.git
      ref: main
    untagged-union:
      git: https://github.com/bklaric/purescript-untagged-union.git
      ref: recursive-castable
    yoga-json:
      git: https://github.com/bklaric/purescript-yoga-json.git
      ref: fix-variant-decoding
```

The bindings import their npm packages but don't depend on them: install the
ones whose modules you use, such as `pg` for `JavaScript.Npm.Pg` or `bcrypt` for
`Bcrypt`.

## Building and testing

```bash
npm install
spago build
spago test    # Jarilo's server and fetch specs, against a server the tests start
```

[src/CLAUDE.md](src/CLAUDE.md) sets out the conventions every binding follows:
file pairing, currying with the subject last, when a binding is `Effect`, how
errors cross the boundary.

## Licence

[AGPL-3.0](LICENSE).
