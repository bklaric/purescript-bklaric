export function parent(window) {
    return function () {
        return window.parent
    }
}

export function top(window) {
    return function () {
        return window.top
    }
}

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

export function localStorage(window) {
    return function () {
        return window.localStorage
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

export function close(window) {
    return function () {
        window.close()
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

export function requestAnimationFrame(callback) {
    return function (window) {
        return function () {
            window.requestAnimationFrame(function (timestamp) {
                callback(timestamp)()
            })
        }
    }
}
