export function fromEffect(effect) {
    return function () {
        return Promise.resolve(effect())
    }
}

export function runPromise(onRejected) {
    return function (onFulfilled) {
        return function (promise) {
            return function () {
                promise().then(
                    fulfilled => onFulfilled(fulfilled)(),
                    rejected => onRejected(rejected)()
                )
            }
        }
    }
}

export function _new(resolveReject) {
    return function () {
        return new Promise((resolve, reject) => resolveReject(
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
    }
}

export function then_(onFulfilled) {
    return function (promise) {
        return function () {
            return promise().then(result => onFulfilled(result)())
        }
    }
}

function catchImpl(onRejected) {
    return function (promise) {
        return function () {
            return promise().catch(result => onRejected(result)())
        }
    }
}
export { catchImpl as catch }

export function thenOrCatch(onFulfilled) {
    return function (onRejected) {
        return function (promise) {
            return function () {
                return promise().then(
                    fulfilled => onFulfilled(fulfilled)(),
                    rejected => onRejected(rejected)()
                )
            }
        }
    }
}

export function bimapImpl(onRejected) {
    return function (onFulfilled) {
        return function (promise) {
            return function () {
                return promise().then(
                    fulfilled => onFulfilled(fulfilled),
                    rejected => Promise.reject(onRejected(rejected))
                )
            }
        }
    }
}

function finallyImpl(onFinally) {
    return function (promise) {
        return function () {
            return promise().finally(onFinally)
        }
    }
}
export { finallyImpl as finally }

export function resolve(right) {
    return function () {
        return Promise.resolve(right)
    }
}

export function reject(left) {
    return function () {
        return Promise.reject(left)
    }
}

export function all(promises) {
    return function () {
        return Promise.all(promises.map(promise => promise()))
    }
}

export function race(promises) {
    return function () {
        return Promise.race(promises.map(promise => promise()))
    }
}
