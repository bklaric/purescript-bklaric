# Writing JavaScript FFI in this library

This library is almost entirely hand-written FFI: 110 `.js` files, each paired with a `.purs`
module of the same name and path, plus ~70 pure PureScript modules with no JS at all. The rules
below are what the existing bindings already do — follow them when adding a new binding, and
prefer copying the nearest existing module over inventing a shape.

## File pairing

- A `.js` file is only ever the FFI for the `.purs` file sitting next to it with the same
  basename. There are no shared/helper `.js` files, no `default` exports, and no `.js` without a
  `.purs`.
- Module path mirrors the API being bound: `JavaScript.Chrome.Tabs` → `chrome.tabs`,
  `JavaScript.Web.DOM.Element` → `Element`, `JavaScript.Node.Fs` → `node:fs`,
  `JavaScript.Npm.<Package>` → an npm package.
- A JS type gets its own module with its own `foreign import data`: [DomRect.purs](JavaScript/Web/DOM/DomRect.purs),
  [Tab.purs](JavaScript/Chrome/Tabs/Tab.purs). Enum-ish string types get a module too
  (`TabStatus`, `OnInstalledReason`, `EventType`).
- Most paired modules carry an explicit export list so the raw `_`-prefixed imports stay private —
  see [Error.purs](JavaScript/Error.purs), [StorageArea.purs](JavaScript/Chrome/Storage/StorageArea.purs),
  [Fs.purs](JavaScript/Node/Fs.purs). Do that for new modules.

## The calling convention

Every export is manually curried, one argument per arrow, with the **subject last** so
the binding reads well under `#` / `>>=`:

```javascript
export const _setAttribute = (name) => (value) => (element) => () => element.setAttribute(name, value)
```

`setAttribute name value element` — the object the method belongs to is the final argument before
the effect thunk. This holds across the library: `_get keys storageArea`, `_addEventListener type
listener options target`, `putObject params client`.

## Effect, pure, and Promise

The innermost `() => …` is the `Effect` thunk. Three cases:

- **Effectful** — thunk it. Anything that mutates, reads live DOM/browser state, or can throw:
  [Element.js](JavaScript/Web/DOM/Element.js), [HtmlImageElement.js](JavaScript/Web/DOM/HtmlElements/HtmlImageElement.js).
- **Pure** — no thunk. Used when the value is fixed for the object's lifetime and reading it
  cannot fail: every `MouseEvent` accessor ([MouseEvent.js](JavaScript/Web/DOM/Events/MouseEvent.js)),
  `Error.name`/`message`/`stack`, `Date.getTime`/`getUTCFullYear`. Contrast `Date.toISOString`,
  which *is* `Effect` because it throws on an invalid date.
- **Promise** — thunk it exactly like an `Effect` and return the native promise from inside:

```javascript
export const _fetch = (resource) => (options) => () => fetch(resource, options)
```

`Promise left right` ([Promise.purs](JavaScript/Promise.purs)) is represented at runtime as
`() => nativePromise`, i.e. identically to `Effect`. That makes it a **cold thunk**: every
`then_` / `bind` / `runPromise` re-invokes it and restarts the work. Never hand a hot promise
across the boundary, and use `Promise.share` when a stored promise must be awaited without
restarting it.

This library binds `Promise` directly and does **not** use `Aff`.

## Naming

| Form | Meaning | Example |
|---|---|---|
| `_foo` (219 uses) | Raw import, and the only marker for one. A public `foo` next to it adds the class constraint, `cast`s unions and optionals, converts `Nullable` → `Maybe`, or injects `Left`/`Right` | `_getAttribute` / `getAttribute`, `_readFileSync`, `_localDate` |
| `defaultFoo` | Default method body for a type class the FFI cannot implement per-instance. Public — other modules import it to write their `instance` — so it takes no `_`, unless it also needs a wrapper, and then it splits like any other raw import (`_defaultRead` / `defaultRead`) | [EventEmitter.js](JavaScript/Node/Events/EventEmitter.js), [Readable.purs](JavaScript/Node/Stream/Readable.purs) |
| `foo_`, `foo__` | Public wrapper with progressively more arguments defaulted | `fetch_`, `sendMessage_`, `sendMessage__` |
| `foo'` | Public wrapper that takes the raw PureScript function and does the `toEventListener` bridging for you | `addListener'`, `addEventListener_'`, `on'` |

One prefix, no second convention: a raw import is `_foo`, never `fooImpl`. `Impl` survives only on
PureScript type names that cannot take a `_` (`QueryConfigImpl`) and on type-class methods that are
not FFI at all (`keysImpl`, `readImpl`).

The `_`-prefix split is load-bearing, not decoration. The raw import is deliberately typed
`forall element. element -> …` — fully unconstrained, so it compiles against anything — and the
exported wrapper is what re-imposes safety:

```purescript
foreign import _getAttribute :: forall element. String -> element -> Effect (Nullable String)

getAttribute :: forall element. Element element => String -> element -> Effect (Maybe String)
getAttribute attribute element = _getAttribute attribute element <#> toMaybe
```

**Reserved words**: PureScript names like `new`, `catch`, `finally`, `undefined` cannot be used as
JS declaration names in every position, so declare under a safe name and re-export:

```javascript
const _new = (message) => new Error(message)
export { _new as new }
```

The safe name is the `_`-prefixed one, so the alias is the only place the reserved word appears.
See [Error.js](JavaScript/Error.js), [Promise.js](JavaScript/Promise.js) (`_catch`,
`_finally`) and [Undefined.js](Undefined.js) — the last documents a real TDZ trap where
`export const undefined = undefined` throws under Node's ESM loader.

## Typing the JS side

- **Opaque handles**: `foreign import data Element :: Type`. Do not model a JS object as a
  PureScript record unless it really is a plain data bag (`UAParserJs.Result`, option records).
- **Inheritance → type classes**: [Class.purs](JavaScript/Web/DOM/Class.purs) mirrors the DOM
  hierarchy (`EventTarget` ⇐ `Node` ⇐ `Element` ⇐ `HtmlElement`, plus the event tree). A new element
  type declares its `instance`s and gets every superclass's methods for free. Upcasts are
  `unsafeCoerce` (`toElement`); downcasts go through `unsafeReadProtoTagged` in
  [Utils.purs](JavaScript/Web/DOM/Utils.purs), which returns `Maybe`.
- **Overloaded JS parameters** → untagged unions `|+|` plus `Castable` / `cast` at the wrapper, so
  callers pass the bare value. Optional parameters are `UndefinedOr a` with
  `Literals.Undefined.undefined`. Fixed string enums are `StringLit "beforebegin" |+| …` — see
  `insertAdjacentHTML` in [Element.purs](JavaScript/Web/DOM/Element.purs), and
  [Fs.purs](JavaScript/Node/Fs.purs) for the heavier version.
- **Nullable at the boundary, Maybe in the API**: the raw import returns `Nullable a` and the
  wrapper applies `toMaybe`. Do not let `Nullable` escape a public signature.
- **Chrome events are phantom-typed** by name and listener shape:
  `foreign import onMessage :: Event "runtime.onMessage" (Foreign -> MessageSender -> (Foreign -> Effect Unit) -> Effect Boolean)`,
  exported from JS as a bare `export const onMessage = chrome.runtime.onMessage`. The generic
  `addListener` / `removeListener` live once in [Event.purs](JavaScript/Chrome/Shared/Event.purs).
- **JSON in and out** is `Foreign` plus `Yoga.JSON` (`write` / `WriteForeign`, `ReadForeign`).
  Storage and messaging additionally gate on `ValidJson`.

## Errors

Two shapes, matching how JS itself fails:

- **Throws** → convert to `Either` inside the JS, with `Left`/`Right` passed in from PureScript
  rather than reconstructed in JS:

```javascript
export const _new = (left) => (right) => (url) => (base) => () => {
    try {
        return right(new URL(url, base))
    }
    catch (error) {
        return left(error)
    }
}
```

  ([URL.js](JavaScript/Web/URL/URL.js), [Fs.js](JavaScript/Node/Fs.js)); the wrapper calls
  `_readFileSync Left Right …`.

- **Rejects** → leave it alone and type the left side: `Promise Error a`. `JavaScript.Error` is the
  error type; `readError` recovers a real `Error` from an arbitrary rejection value.

- **Node callbacks** `(error, …)` branch into separate error and success callbacks passed in
  from PureScript, with the wrapper injecting `Left`/`Right`: [Bcrypt.js](Bcrypt.js),
  [Crypto.js](JavaScript/Node/Crypto.js).

## Listeners

Two bridges, both named `toEventListener`:

- DOM ([EventTarget.js](JavaScript/Web/DOM/EventTarget.js)) — wraps `event -> Effect r` into a plain
  JS listener. It is itself `Effect`-returning so each call yields a distinct, retainable function
  reference that `removeEventListener` can actually match.
- Chrome ([Event.js](JavaScript/Chrome/Shared/Event.js)) — pure and variadic, and re-curries any
  argument that is itself a function (e.g. `sendResponse`) so the PureScript listener receives it in
  curried, thunked form.

## Imports and globals

- Import npm/Node modules with ESM at the top of the `.js`: `import * as fs from 'fs'`,
  `import { UAParser } from 'ua-parser-js'`. Globals available in the runtime (`chrome`, `fetch`,
  `window`, `Promise`) are referenced directly, no import.
- **Global gotcha**: a bare `export const window = window` self-shadows and breaks the global.
  Export a thunked `_window` and alias it in PureScript — see the comment in
  [Globals.js](JavaScript/Web/DOM/Globals.js).

## Style

- 4-space indent, no semicolons.
- `export const` with arrow lambdas, always — never `export function` and never
  `export const f = function (x) {…}`. One curried binding is one chain of arrows on one line where
  it fits ([Scripting.js](JavaScript/Chrome/Scripting.js), [Date.js](JavaScript/Date.js)); when it
  does not, break after the last `=>` and indent the body four spaces
  ([Bcrypt.js](Bcrypt.js), [Runtime.js](JavaScript/Chrome/Runtime.js)). A body that is a single
  expression needs no braces even when it returns nothing — `() => params.set(key, value)`. Braces
  are for bodies that are genuinely more than one statement, or a `try`/`catch`.
- The one exception: a function whose body reads `arguments` or `this` stays a classic `function`,
  because an arrow binds neither. Only the variadic listener bridges need this —
  [Event.js](JavaScript/Chrome/Shared/Event.js), [EventListener.js](JavaScript/Node/Events/EventListener.js).
- Comment the *why*, in the `.purs` where possible: why a binding is pure rather than `Effect`, why
  a field is `Number` not `Int`, why a response is dropped. [Date.purs](JavaScript/Date.purs),
  [Error.purs](JavaScript/Error.purs) and [Promise.purs](JavaScript/Promise.purs) are the models.
- Link the spec above the imports: `-- https://developer.mozilla.org/en-US/docs/…`.

## Checklist for a new binding

1. Find the module the API belongs to, or create `JavaScript/<Area>/<Api>.{purs,js}`.
2. Write the JS as an arrow chain, curried, subject-last, thunked if effectful or promise-returning.
3. Declare the raw `foreign import` unconstrained and `_`-prefixed — including when it needs
   `Left` / `Right` / `cast` injected from PureScript.
4. Export a wrapper that adds the class constraint, `cast`s unions and optionals, and converts
   `Nullable` → `Maybe`.
5. Keep the raw name out of the module's export list.
6. `spago build` from **this** repo, not the consumer — the compiler is the only check; there are no
   FFI tests.
