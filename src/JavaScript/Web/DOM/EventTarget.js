export const toEventListener = (listener) => () => (event) => listener(event)()

export const _addEventListener = (eventType) => (listener) => (options) => (target) => () =>
    target.addEventListener(eventType, listener, options)

export const _removeEventListener = (eventType) => (listener) => (target) => () =>
    target.removeEventListener(eventType, listener)

export const _dispatchEvent = (event) => (target) => () => target.dispatchEvent(event)
