export function getImpl(keys) {
    return function (storageArea) {
        return function () {
            return storageArea.get(keys)
        }
    }
}

export function setImpl(record) {
    return function (storageArea) {
        return function () {
            return storageArea.set(record)
        }
    }
}
