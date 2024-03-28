export const defaultWritableHighWaterMark = function (stream) {
    return stream.writableHighWaterMark
}

export const defaultWritableLength = function (stream) {
    return stream.writableLength
}

export const defaultCork = function (stream) {
    return function () {
        stream.cork()
    }
}

export const defaultUncork = function (stream) {
    return function () {
        stream.uncork()
    }
}

export const defaultWrite = function (toWrite) {
    return function (callback) {
        return function (stream) {
            return function () {
                return stream.write(toWrite, callback)
            }
        }
    }
}

export const defaultEnd = function (toWrite) {
    return function (callback) {
        return function (stream) {
            return function () {
                return stream.end(toWrite, callback)
            }
        }
    }
}

export const defaultDestroy = function (error) {
    return function (stream) {
        return function () {
            return stream.destroy(error)
        }
    }
}
