export function offsetWidthDefault(element) {
    return function () {
        return element.offsetWidth
    }
}

export function offsetHeightDefault(element) {
    return function () {
        return element.offsetHeight
    }
}

export function styleDefault(element) {
    return function () {
        return element.style
    }
}
