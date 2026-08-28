const _new = (callback) => () => new MutationObserver((records, observer) => callback(records)(observer)())

export { _new as new }

export const _observe = (node) => (options) => (observer) => () => observer.observe(node, options)

export const disconnect = (observer) => () => observer.disconnect()

export const takeRecords = (observer) => () => observer.takeRecords()
