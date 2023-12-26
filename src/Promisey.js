function newImpl(resolveReject) {
    return function () {
        return new Promise((resolve, reject) => resolveReject(resolve)(reject)())
    }
}
export { newImpl as new }

export function then_(onFulfilled) {
    return function (promise) {
        return function () {
            return promise.then(result => onFulfilled(result)())
        }
    }
}

function catchImpl(onRejected) {
    return function (promise) {
        return function () {
            return promise.catch(result => onRejected(result)())
        }
    }
}
export { catchImpl as catch }

export function thenOrCatch(onFulfilled) {
    return function (onRejected) {
        return function (promise) {
            return function () {
                return promise.then(
                    fulfilled => onFulfilled(fulfilled)(),
                    rejected => onRejected(rejected)()
                )
            }
        }
    }
}

function finallyImpl(onFinally) {
    return function (promise) {
        return function () {
            return promise.finally(onFinally)
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
        return Promise.all(promises)
    }
}

export function race(promises) {
    return function () {
        return Promise.race(promises)
    }
}
