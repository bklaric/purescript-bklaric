function _new(callback) {
    return function () {
        return new MutationObserver(function (records, observer) {
            return callback(records)(observer)()
        })
    }
}

export { _new as new }

export function _observe(node) {
    return function (options) {
        return function (observer) {
            return function () {
                return observer.observe(node, options)
            }
        }
    }
}

export function disconnect(observer) {
    return function () {
        return observer.disconnect()
    }
}

export function takeRecords(observer) {
    return function () {
        return observer.takeRecords()
    }
}
