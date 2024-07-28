export function toEventListener(listener) {
    return function () {
        return function (event) {
            return listener(event)()
        }
    }
}

export function _addEventListener(eventType) {
    return function (listener) {
        return function (options) {
            return function (target) {
                return function () {
                    target.addEventListener(eventType, listener, options)
                }
            }
        }
    }
}


export function _removeEventListener(eventType) {
    return function (listener) {
        return function (target) {
            return function () {
                target.removeEventListener(eventType, listener)
            }
        }
    }
}

export function _dispatchEvent(event) {
    return function (target) {
        return function () {
            return target.dispatchEvent(event)
        }
    }
}
