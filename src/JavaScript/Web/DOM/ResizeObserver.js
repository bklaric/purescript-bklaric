const _new = (callback) => () => new ResizeObserver((entries, observer) => callback(observer)())

export { _new as new }

export const _observe = (element) => (observer) => () => observer.observe(element)

export const _unobserve = (element) => (observer) => () => observer.unobserve(element)

export const disconnect = (observer) => () => observer.disconnect()
