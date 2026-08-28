import * as timers from "timers"

export function setInterval(delay) {
    return function (callback) {
        return function () {
            return timers.setInterval(callback, delay)
        }
    }
}

export function clearInterval(timeout) {
    return function () {
        timers.clearInterval(timeout)
    }
}

export function ref(timeout) {
    return function () {
        timeout.ref()
    }
}

export function unref(timeout) {
    return function () {
        timeout.unref()
    }
}
