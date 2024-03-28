export const defaultReadableHighWaterMark = function (readable) {
    return function () {
        return readable.readableHighWaterMark
    }
}

export const defaultReadableLength = function (readable) {
    return function () {
        return readable.readableLength
    }
}

export const defaultIsPaused = function (readable) {
    return function () {
        return readable.isPaused()
    }
}

export const defaultReadImpl = function (size) {
    return function (readable) {
        return function () {
            return readable.read(size)
        }
    }
}

export const defaultResume = function (readable) {
    return function () {
        return readable.resume()
    }
}

export const defaultPause = function (readable) {
    return function () {
        return readable.pause()
    }
}

export const defaultPipe = function (writable) {
    return function (end) {
        return function (readable) {
            return function () {
                return readable.pipe(writable, end)
            }
        }
    }
}

export const defaultUnpipe = function (writable) {
    return function (readable) {
        return function () {
            readable.unpipe(writable)
        }
    }
}

export const defaultSetEncodingImpl = function (encoding) {
    return function (readable) {
        return function () {
            return readable.setEncoding(encoding)
        }
    }
}

export const defaultUnshift = function (chunk) {
    return function (readable) {
        return function () {
            readable.unshift(chunk)
        }
    }
}

export const defaultDestroy = function (error) {
    return function (readable) {
        return function () {
            readable.destroy(error)
        }
    }
}
