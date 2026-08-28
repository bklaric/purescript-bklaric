export const _get = (keys) => (storageArea) => () => storageArea.get(keys)

export const _set = (record) => (storageArea) => () => storageArea.set(record)

export const _remove = (keys) => (storageArea) => () => storageArea.remove(keys)
