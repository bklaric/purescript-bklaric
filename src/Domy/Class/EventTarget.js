export function toEventListener(listener) {
    return function () {
        return function (event) {
            return listener(event)()
        }
    }
}

export function addEventListenerImpl(eventType) {
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


export function removeEventListenerImpl(eventType) {
    return function (listener) {
        return function (target) {
            return function () {
                target.removeEventListener(eventType, listener)
            }
        }
    }
}

export function dispatchEventImpl(event) {
    return function (target) {
        return function () {
            return target.dispatchEvent(event)
        }
    }
}
