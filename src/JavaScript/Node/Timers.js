import * as timers from "timers"

export const setInterval = (delay) => (callback) => () => timers.setInterval(callback, delay)

export const clearInterval = (timeout) => () => timers.clearInterval(timeout)

export const ref = (timeout) => () => timeout.ref()

export const unref = (timeout) => () => timeout.unref()
