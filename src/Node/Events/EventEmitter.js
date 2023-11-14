export const defaultOn = function (event) {
    return function (listener) {
        return function (emitter) {
            return function () {
                return emitter.on(event, listener)
            }
        }
    }
}

export const defaultOnce = function (event) {
    return function (listener) {
        return function (emitter) {
            return function () {
                return emitter.once(event, listener)
            }
        }
    }
}

export const defaultPrependListener = function (event) {
    return function (listener) {
        return function (emitter) {
            return function () {
                return emitter.prependListener(event, listener)
            }
        }
    }
}

export const defaultPrependOnceListener = function (event) {
    return function (listener) {
        return function (emitter) {
            return function () {
                return emitter.prependOnceListener(event, listener)
            }
        }
    }
}

export const defaultRemoveListener = function (event) {
    return function (listener) {
        return function (emitter) {
            return function () {
                return emitter.removeListener(event, listener)
            }
        }
    }
}

export const defaultRemoveAllListeners = function (event) {
    return function (emitter) {
        return function () {
            return emitter.removeAllListeners(event)
        }
    }
}

export const defaultEmit = function (event) {
    return function (args) {
        return function (emitter) {
            return function () {
                return emitter.emit(event, args)
            }
        }
    }
}

export const defaultListeners = function (event) {
    return function (emitter) {
        return function () {
            return emitter.listeners(event)
        }
    }
}

export const defaultListenerCount = function (event) {
    return function (emitter) {
        return function () {
            return emitter.listenerCount(event)
        }
    }
}

export const defaultGetMaxListeners = function (emitter) {
    return function () {
        return emitter.getMaxListeners()
    }
}

export const defaultSetMaxListeners = function (listenerCount) {
    return function (emitter) {
        return function () {
            return emitter.setMaxListeners(listenerCount)
        }
    }
}

export const defaultEventNames = function (emitter) {
    return function () {
        return emitter.eventNames()
    }
}
