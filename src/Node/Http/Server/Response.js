export const addTrailers = function (trailers) {
    return function (response) {
        return function () {
            response.addTrailers(trailers)
        }
    }
}

export const finished = function (response) {
    return function () {
        return response.finished
    }
}

export const getHeader = function (headerName) {
    return function (response) {
        return function () {
            return response.getHeader(headerName)
        }
    }
}

export const getHeaderNames = function (response) {
    return function () {
        return response.getHeaderNames()
    }
}

export const getHeaders = function (response) {
    return function () {
        return response.getHeaders()
    }
}

export const hasHeader = function (headerName) {
    return function (response) {
        return function () {
            return response.hasHeader(headerName)
        }
    }
}

export const headersSent = function (response) {
    return function () {
        return response.headersSent
    }
}

export const removeHeader = function (headerName) {
    return function (response) {
        return function () {
            response.removeHeader(headerName)
        }
    }
}

export const getSendDate = function (response) {
    return function () {
        return response.sendDate
    }
}

export const setSendDate = function (sendDate) {
    return function (response) {
        return function () {
            response.sendDate = sendDate
        }
    }
}

export const setHeaderImpl = function (headerName) {
    return function (headerValueOrValues) {
        return function (response) {
            return function () {
                response.setHeader(headerName, headerValueOrValues)
            }
        }
    }
}

export const defaultSetTimeout = function (milliseconds) {
    return function (callback) {
        return function (response) {
            return function () {
                return response.setTimeout(milliseconds, callback)
            }
        }
    }
}

export const getStatusCode = function (response) {
    return function () {
        return response.statusCode
    }
}

export const setStatusCode = function (statusCode) {
    return function (response) {
        return function () {
            response.statusCode = statusCode
        }
    }
}

export const getStatusMessage = function (response) {
    return function () {
        return response.statusMessage
    }
}

export const setStatusMessage = function (statusMessage) {
    return function (response) {
        return function () {
            response.statusMessage = statusMessage
        }
    }
}

export const writeContinue = function (response) {
    return function () {
        response.writeContinue()
    }
}

export const writeHead = function (statusCode) {
    return function (statusMessage) {
        return function (headers) {
            return function (response) {
                return function () {
                    response.writeHead(statusCode, statusMessage, headers)
                }
            }
        }
    }
}
