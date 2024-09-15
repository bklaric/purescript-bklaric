export function document(window) {
    return function () {
        return window.document
    }
}

export function location(window) {
    return function () {
        return window.location
    }
}

export function navigator(window) {
    return function () {
        return window.navigator
    }
}

export function innerWidth(window) {
    return function () {
        return window.innerWidth
    }
}

export function innerHeight(window) {
    return function () {
        return window.innerHeight
    }
}

export function scrollBy(x) {
    return function (y) {
        return function (window) {
            return function () {
                return window.scrollBy(x, y)
            }
        }
    }
}

export function open(url) {
    return function (target) {
        return function (features) {
            return function (window) {
                return function () {
                    return window.open(url, target, features)
                }
            }
        }
    }
}

export function _getComputedStyle(element) {
    return function (pseudoElement) {
        return function (window) {
            return function () {
                return window.getComputedStyle(element, pseudoElement)
            }
        }
    }
}
