export function _new(left) {
    return function (right) {
        return function (url) {
            return function (options) {
                return function () {
                    try {
                        return right(new Worker(url, options))
                    }
                    catch (error) {
                        return left(error)
                    }
                }
            }
        }
    }
}

export function _postMessage(message) {
    return function (worker) {
        return function () {
            worker.postMessage(message)
        }
    }
}
