import * as Buffer from "buffer"

export const allocImpl = function (size) {
    return function (fill) {
        return function (encoding) {
            return function () {
                return Buffer.Buffer.alloc(size, fill, encoding)
            }
        }
    }
}

export const fromStringImpl = function (string) {
    return function (encoding) {
        return function () {
            return Buffer.Buffer.from(string, encoding)
        }
    }
}

export const concat = function (buffers) {
    return function (totalLength) {
        return function () {
            return Buffer.Buffer.concat(buffers, totalLength)
        }
    }
}

export const toStringImpl = function (encoding) {
    return function (start) {
        return function (end) {
            return function (buffer) {
                return function () {
                    return buffer.toString(encoding, start, end)
                }
            }
        }
    }
}
