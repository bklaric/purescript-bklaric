export const addTrailers = (trailers) => (response) => () => response.addTrailers(trailers)

export const finished = (response) => () => response.finished

export const getHeader = (headerName) => (response) => () => response.getHeader(headerName)

export const getHeaderNames = (response) => () => response.getHeaderNames()

export const getHeaders = (response) => () => response.getHeaders()

export const hasHeader = (headerName) => (response) => () => response.hasHeader(headerName)

export const headersSent = (response) => () => response.headersSent

export const removeHeader = (headerName) => (response) => () => response.removeHeader(headerName)

export const getSendDate = (response) => () => response.sendDate

export const setSendDate = (sendDate) => (response) => () => response.sendDate = sendDate

export const _setHeader = (headerName) => (headerValueOrValues) => (response) => () =>
    response.setHeader(headerName, headerValueOrValues)

export const defaultSetTimeout = (milliseconds) => (callback) => (response) => () =>
    response.setTimeout(milliseconds, callback)

export const getStatusCode = (response) => () => response.statusCode

export const setStatusCode = (statusCode) => (response) => () => response.statusCode = statusCode

export const getStatusMessage = (response) => () => response.statusMessage

export const setStatusMessage = (statusMessage) => (response) => () => response.statusMessage = statusMessage

export const writeContinue = (response) => () => response.writeContinue()

export const writeHead = (statusCode) => (statusMessage) => (headers) => (response) => () =>
    response.writeHead(statusCode, statusMessage, headers)
