function _new(message) {
    return new Error(message);
}

export { _new as new }

export function _name(error) {
    return error.name
}

export function _message(error) {
    return error.message
}

export function _stack(error) {
    return error.stack
}

export function _cause(error) {
    return error.cause === undefined ? null : error.cause
}
