export const httpVersion = (message) => message.httpVersion

export const rawHeaders = (message) => message.rawHeaders

export const headers = (message) => message.headers

export const headersDistinct = (message) => message.headersDistinct

export const trailers = (message) => () => message.trailers

export const setTimeout = (milliseconds) => (callback) => (message) => () =>
    message.setTimeout(milliseconds, callback)

export const destroy = (error) => (message) => () => message.destroy(error)

export const _method = (request) => request.method

export const _url = (request) => request.url
