const _new = () => new AbortController()
export { _new as new }

export const signal = (controller) => controller.signal

export const abort = (controller) => () => controller.abort()
