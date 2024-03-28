export const defaultHttpVersion = function (message) {
    return message.httpVersion
}

export const defaultRawHeaders = function (message) {
    return message.rawHeaders
}

export const defaultHeaders = function (message) {
    return message.headers
}

export const defaultTrailers = function (message) {
    return message.trailers
}

export const defaultSetTimeout = function (milliseconds) {
    return function (callback) {
        return function (message) {
            return function () {
                return message.setTimeout(milliseconds, callback)
            }
        }
    }
}

export const defaultDestroy = function (error) {
    return function (message) {
        return function () {
            message.destroy(error)
        }
    }
}
