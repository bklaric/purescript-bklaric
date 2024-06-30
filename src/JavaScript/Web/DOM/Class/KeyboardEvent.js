export function keyDefault(keyboardEvent) {
    return keyboardEvent.key
}

export function codeDefault(keyboardEvent) {
    return keyboardEvent.code
}

export function altKeyDefault(keyboardEvent) {
    return keyboardEvent.altKey
}

export function ctrlKeyDefault(keyboardEvent) {
    return keyboardEvent.ctrlKey
}

export function shiftKeyDefault(keyboardEvent) {
    return keyboardEvent.shiftKey
}

export function metaKeyDefault(keyboardEvent) {
    return keyboardEvent.metaKey
}

export function getModifierStateDefault(key) {
    return function (keyboardEvent) {
        return keyboardEvent.getModifierState(key)
    }
}
