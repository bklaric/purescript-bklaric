export function _preventDefault(event) {
    return function () {
        event.preventDefault()
    }
}

export function _stopPropagation(event) {
    return function () {
        event.stopPropagation()
    }
}

export function _stopImmediatePropagation(event) {
    return function () {
        event.stopImmediatePropagation()
    }
}

export function _target(event) {
    return event.target
}
