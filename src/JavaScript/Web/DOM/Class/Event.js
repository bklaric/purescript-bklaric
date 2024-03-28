export function preventDefaultImpl(event) {
    return function () {
        event.preventDefault()
    }
}

export function stopPropagationImpl(event) {
    return function () {
        event.stopPropagation()
    }
}

export function stopImmediatePropagationImpl(event) {
    return function () {
        event.stopImmediatePropagation()
    }
}
