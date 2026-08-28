export const fromEffect = (effect) => () => Promise.resolve(effect())

export const runPromise = (onRejected) => (onFulfilled) => (promise) => () =>
    promise().then(
        fulfilled => onFulfilled(fulfilled)(),
        rejected => onRejected(rejected)()
    )

export const _new = (resolveReject) => () =>
    new Promise((resolve, reject) => resolveReject(
        valueOrPromise => function () {
            // We can receive either a regular value or a Promise.
            // Since Promise is an effectful monad, we need to call it before passing it to the resolver.
            if (valueOrPromise && valueOrPromise.__proto__ && valueOrPromise.__proto__.constructor && valueOrPromise.__proto__.constructor.name == "Function") {
                resolve(valueOrPromise())
            }
            else {
                resolve(valueOrPromise)
            }
        })
        (error => function () {
            reject(error)
        })
        ()
    )

export const then_ = (onFulfilled) => (promise) => () => promise().then(result => onFulfilled(result)())

const _catch = (onRejected) => (promise) => () => promise().catch(result => onRejected(result)())
export { _catch as catch }

export const thenOrCatch = (onFulfilled) => (onRejected) => (promise) => () =>
    promise().then(
        fulfilled => onFulfilled(fulfilled)(),
        rejected => onRejected(rejected)()
    )

export const _bimap = (onRejected) => (onFulfilled) => (promise) => () =>
    promise().then(
        fulfilled => onFulfilled(fulfilled),
        rejected => Promise.reject(onRejected(rejected))
    )

const _finally = (onFinally) => (promise) => () => promise().finally(onFinally)
export { _finally as finally }

export const resolve = (right) => () => Promise.resolve(right)

export const reject = (left) => () => Promise.reject(left)

export const all = (promises) => () => Promise.all(promises.map(promise => promise()))

export const race = (promises) => () => Promise.race(promises.map(promise => promise()))

// Start the promise now and hand every caller the same in-flight one. A Promise
// here is a cold thunk -- every then_/runPromise re-invokes it and starts the
// work again -- so this is what makes a stored promise usable as a shared handle:
// as an in-flight mutex, or as something to await without restarting it.
export const share = (promise) => () => {
    const started = promise()
    return function () {
        return started
    }
}
