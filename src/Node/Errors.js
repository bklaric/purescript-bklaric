export const stackTraceLimit = function () {
    return Error.stackTraceLimit
}

export const setStackTraceLimit = function (limit) {
    return function () {
        Error.stackTraceLimit = limit
    }
}
