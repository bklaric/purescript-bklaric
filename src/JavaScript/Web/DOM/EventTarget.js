export const toEventListener = (listener) => () => (event) => listener(event)()

export const _addEventListener = (eventType) => (listener) => (options) => (target) => () =>
    target.addEventListener(eventType, listener, options)

export const _removeEventListener = (eventType) => (listener) => (options) => (target) => () =>
    target.removeEventListener(eventType, listener, options)

export const _dispatchEvent = (event) => (target) => () => target.dispatchEvent(event)
