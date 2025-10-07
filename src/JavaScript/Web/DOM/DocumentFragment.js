export function _querySelector(selector) {
    return function (documentFragment) {
        return function () {
            return documentFragment.querySelector(selector)
        }
    }
}

export function _querySelectorAll(selector) {
    return function (documentFragment) {
        return function () {
            return documentFragment.querySelectorAll(selector)
        }
    }
}
