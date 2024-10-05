export function _get(keys) {
    return function (storageArea) {
        return function () {
            return storageArea.get(keys)
        }
    }
}

export function _set(record) {
    return function (storageArea) {
        return function () {
            return storageArea.set(record)
        }
    }
}
