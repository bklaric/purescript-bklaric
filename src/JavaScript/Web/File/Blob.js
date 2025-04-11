export function _new(blobParts) {
    return function (options) {
        return function () {
            return new Blob(blobParts, options)
        }
    }
}

export function type_(blob) {
    return blob.type
}
