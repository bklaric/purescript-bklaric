export function _key(keyboardEvent) {
    return keyboardEvent.key
}

export function _code(keyboardEvent) {
    return keyboardEvent.code
}

export function _altKey(keyboardEvent) {
    return keyboardEvent.altKey
}

export function _ctrlKey(keyboardEvent) {
    return keyboardEvent.ctrlKey
}

export function _shiftKey(keyboardEvent) {
    return keyboardEvent.shiftKey
}

export function _metaKey(keyboardEvent) {
    return keyboardEvent.metaKey
}

export function _getModifierState(key) {
    return function (keyboardEvent) {
        return keyboardEvent.getModifierState(key)
    }
}
