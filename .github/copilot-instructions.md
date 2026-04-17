# purescript-bklaric — Copilot Instructions

## Project Overview

Custom PureScript library providing FFI bindings to JavaScript/browser/Node.js/Chrome extension APIs, plus utility types and abstractions. Used as a **local dependency** by the Enhanced Image Viewer Chrome extension (sibling workspace). Not a standalone app — no entry point, no bundling.

## Tech Stack

- **Language**: PureScript 0.15.15 with JavaScript FFI
- **Build**: `spago build` (built as part of the workspace build)
- **Node**: 22.20.0 (pinned via Volta)
- **Package set**: PureScript registry 44.3.0

## Module Inventory

### `JavaScript.Chrome.*` — Chrome Extension APIs (MV3)

- `Action` — `setBadgeText`, `onClicked`
- `Commands` — `onCommand`
- `Downloads` — `download`, `search`, `getFileIcon`, events. Sub-modules: `DangerType`, `DownloadItem`, `FilenameConflictAction`, `InterruptReason`, `State`
- `Extension` — `inIncognitoContext`
- `I18n` — `getMessage`, `getUILanguage`
- `Management` — `getSelf`. Sub-modules: `ExtensionInfo`, `ExtensionInstallType`
- `Menus` — `create`, `update`, `remove`, `removeAll`. Sub-module: `OnClickData`
- `Notifications` — `create`, `clear`, `getAll`, events
- `Runtime` — `sendMessage`, `openOptionsPage`, `getManifest`, `id`, `getURL`, `setUninstallURL`, `reload`, events. Sub-modules: `MessageSender`, `OnInstalledReason`
- `Scripting` — `executeScript`, `insertCSS`. Types: `ExecutionWorld`, `InjectionTarget`, `ScriptInjection`
- `Sessions` — `getRecentlyClosed`, `restore`. Sub-module: `Session`
- `Storage` — `local`/`managed`/`session`/`sync` `StorageArea` instances. Sub-module: `StorageArea` (`get`/`getAll`/`getByKey`/`set`/`remove`)
- `Tabs` — `sendMessage`, `get`, `getCurrent`, `create`, `update`, `query`, events. Sub-modules: `Tab`, `TabStatus`
- `WebNavigation` — `onBeforeNavigate`, `onCommitted`, `onCompleted`
- `WebRequest` — `addListener`, events. Sub-modules: `HttpHeaders`, `RequestFilter`, `ResourceType`, `UploadData`
- `Windows` — `create`, `get`, `getAll`. Sub-modules: `Window`, `WindowType`
- `Shared.Event` — Phantom-typed Chrome event system: `addListener`/`removeListener`/`hasListener`

### `JavaScript.Web.DOM.*` — DOM APIs

- `Class` — Type class hierarchy mirroring DOM inheritance (`EventTarget` < `Node` < `Element` < `HtmlElement`, event class hierarchy)
- `Document` — `querySelector`, `querySelectorAll`, `body`, `head`, `createElement`, `getElementById`, etc.
- `Element` — `getBoundingClientRect`, `getAttribute`/`setAttribute`, `innerHTML`/`outerHTML`, `insertAdjacentHTML`, `scrollBy`, `classList`, `closest`, `remove`, etc.
- `Node` — `isConnected`, `parentElement`, `appendChild`, `textContent`, `cloneNode`, etc.
- `EventTarget` — `addEventListener`/`removeEventListener` with typed options (capture/once/passive)
- `Window` — `location`, `navigator`, `innerWidth`/`innerHeight`, `requestAnimationFrame`, `getComputedStyle`, etc.
- `Globals` — Global accessors: `window`, `document`, `location`, `localStorage`
- `Location` — `protocol`, `hostname`, `pathname`, `href`/`setHref`, `replace`, etc.
- `Navigator` — `userAgent`, `language`, `clipboard`
- `CssStyleDeclaration` — `getPropertyValue`/`setProperty`/`cssText`
- `DomRect` — `top`/`right`/`bottom`/`left`/`width`/`height`
- `DomTokenList` — `add`/`remove`/`toggle`/`contains`
- `MutationObserver` — `new`, `observe`, `disconnect`
- `MutationRecord` — `type`, `target`, `addedNodes`, `attributeName`
- **Events**: `Event`, `MouseEvent`, `KeyboardEvent`, `WheelEvent`, `FocusEvent`, `TouchEvent`, `PointerEvent`, `ErrorEvent`, `MessageEvent`, `PopStateEvent`, `PromiseRejectionEvent`
- **HTML Elements**: `HtmlElement`, `HtmlImageElement`, `HtmlInputElement`, `HtmlCanvasElement`, `HtmlAnchorElement`, `HtmlIframeElement`, `HtmlFormElement`, `HtmlButtonElement`, `HtmlDivElement`, `HtmlBodyElement`, etc.

### `JavaScript.Web.*` — Other Web APIs

- `Fetch` — `fetch`/`fetch_`, `Request`, `RequestInit`, `Response` (`status`/`text`/`json`/`blob`), `Headers`
- `Clipboard` — `write`, `ClipboardItem`
- `Crypto` — `randomUUID`
- `File.Blob` — `new`, `type`
- `URL` — `new`, `protocol`/`hostname`/`pathname`/`href`, `searchParams`, `createObjectURL`
- `URLSearchParams` — `new`, `get`/`set`/`toString`
- `WebStorage.Storage` — `getItem`/`setItem`/`removeItem`/`clear`
- `WebAnimations` — `AnimationTimeline`, `DocumentTimeline`
- `SVG` — `SVGElement` type class
- `WebWorkers.Worker` — `new`, `postMessage`, `terminate`

### `JavaScript.Node.*` — Node.js APIs

- `Buffer` — `alloc`, `fromString`, `concat`, `toString` with typed `Encoding`
- `Crypto` — `randomBytes`/`randomBytesSync`
- `Fs` — `readFileSync`
- `Process` — `lookupEnv`, `env`
- `Http.Server` — `createServer`, `IncomingMessage`, `ServerResponse`
- `Net.Server` — `listen`, `close`
- `Stream.Readable`/`Writable` — type classes with events
- `Events.EventEmitter` — type class for Node.js event emitters

### `JavaScript.Promise` — Direct Promise FFI

Two type parameters: `Promise left right`. Full monadic instances (`Functor`/`Apply`/`Bind`/`Monad`/`MonadEffect`). Key functions: `new`, `resolve`, `reject`, `then_`, `catch`, `thenOrCatch`, `all`, `race`, `runPromise`.

### `Postgres.*` — PostgreSQL (node-postgres)

- `Pool` — connection pooling, `Querier` type class
- `Client` — direct client
- `Query` — `QueryParameter` with `:` / `:|` operators
- `Result` — `rows`, `fields`, `rowCount`
- `Error` — Postgres-specific errors with `severity`/`detail`/`constraint`

### Utility Modules

- `Async` — CPS-based async monad (`ExceptT left (ContT Unit Effect) right`), not Aff-based
- `AsyncV` — Validated async (accumulates errors)
- `Untagged.Union` — `OneOf a b` (aliased as `a |+| b`) untagged union types
- `Untagged.Castable` — Safe zero-cost coercion with `cast`
- `Untagged.TypeCheck` — Runtime type checking for union discrimination
- `Undefined` — The JS `undefined` value
- `Data.Validated` — Applicative validation (accumulates errors via `Semigroup`)
- `LmapExpandError` — Prepend context to error messages
- `Bcrypt` / `Bcrypt.Async` — bcrypt bindings

## Coding Conventions

### FFI Pattern

Every effectful JS export uses curried thunking:
```javascript
export function setAttribute(name) {
    return function(value) {
        return function(element) {
            return function() { element.setAttribute(name, value) }
        }
    }
}
```

Promises are also thunked so PureScript controls when they start:
```javascript
export function text(response) {
    return function() { return response.text() }
}
```

### Naming Conventions

- **`_`-prefixed private FFI functions**: Raw nullable versions (e.g., `_querySelector`), with public `Maybe`-wrapped versions (e.g., `querySelector`)
- **Underscore suffixes for overloads**: `foo` (all params), `foo_` (some defaults), `foo__` (most defaults)
- **Module naming mirrors API structure**: `JavaScript.Chrome.Tabs` → `chrome.tabs`
- **4-space indentation**
- **Pipe-friendly API**: subject as last argument (`setAttribute name value element`)

### Type Patterns

- **Untagged unions** (`|+|`) for JS APIs accepting multiple types
- **`Castable`** for compile-time safe coercion, especially records with optional fields
- **Type class hierarchies** mirror DOM inheritance
- **Phantom-typed events**: `Event "runtime.onMessage" ListenerType`
- **`UndefinedOr a`** for optional parameters (`OneOf Undefined a`)
- **`Nullable`** → `Maybe` conversion in public API wrappers
