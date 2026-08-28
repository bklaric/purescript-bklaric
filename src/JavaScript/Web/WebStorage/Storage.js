export const length = (storage) => () => storage.length

export const _key = (index) => (storage) => () => storage.key(index)

export const _getItem = (key) => (storage) => () => storage.getItem(key)

export const setItem = (key) => (value) => (storage) => () => storage.setItem(key, value)

export const removeItem = (key) => (storage) => () => storage.removeItem(key)

export const clear = (storage) => () => storage.clear()
