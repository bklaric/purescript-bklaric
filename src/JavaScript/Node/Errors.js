export const stackTraceLimit = () => Error.stackTraceLimit

export const setStackTraceLimit = (limit) => () => Error.stackTraceLimit = limit
