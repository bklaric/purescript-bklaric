export const defaultOn = (event) => (listener) => (emitter) => () => emitter.on(event, listener)

export const defaultOnce = (event) => (listener) => (emitter) => () => emitter.once(event, listener)

export const defaultPrependListener = (event) => (listener) => (emitter) => () =>
    emitter.prependListener(event, listener)

export const defaultPrependOnceListener = (event) => (listener) => (emitter) => () =>
    emitter.prependOnceListener(event, listener)

export const defaultRemoveListener = (event) => (listener) => (emitter) => () =>
    emitter.removeListener(event, listener)

export const defaultRemoveAllListeners = (event) => (emitter) => () => emitter.removeAllListeners(event)

export const defaultEmit = (event) => (args) => (emitter) => () => emitter.emit(event, args)

export const defaultListeners = (event) => (emitter) => () => emitter.listeners(event)

export const defaultListenerCount = (event) => (emitter) => () => emitter.listenerCount(event)

export const defaultGetMaxListeners = (emitter) => () => emitter.getMaxListeners()

export const defaultSetMaxListeners = (listenerCount) => (emitter) => () =>
    emitter.setMaxListeners(listenerCount)

export const defaultEventNames = (emitter) => () => emitter.eventNames()
