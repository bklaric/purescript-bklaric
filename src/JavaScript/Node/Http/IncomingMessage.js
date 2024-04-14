export const httpVersion = function (message) {
    return message.httpVersion
}

export const rawHeaders = function (message) {
    return message.rawHeaders
}

export const headers = function (message) {
    return message.headers
}

export const headersDistinct = function (message) {
    return message.headersDistinct
}

export const trailers = function (message) {
    return message.trailers
}

export const setTimeout = function (milliseconds) {
    return function (callback) {
        return function (message) {
            return function () {
                return message.setTimeout(milliseconds, callback)
            }
        }
    }
}

export const destroy = function (error) {
    return function (message) {
        return function () {
            message.destroy(error)
        }
    }
}

export const methodImpl = function (request) {
    return request.method
}

export const urlImpl = function (request) {
    return request.url
}
