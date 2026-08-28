const _new = (message) => new Error(message)

export { _new as new }

export const _name = (error) => error.name

export const _message = (error) => error.message

export const _stack = (error) => error.stack

export const _cause = (error) => error.cause === undefined ? null : error.cause
