export function querySelectorImpl(selector) {
    return function (document) {
        return function () {
            return document.querySelector(selector)
        }
    }
}

export function querySelectorAll(selector) {
    return function (document) {
        return function () {
            return document.querySelectorAll(selector)
        }
    }
}

export function body(document) {
    return function () {
        return document.body
    }
}

export function documentElementImpl(document) {
    return function () {
        return document.documentElement
    }
}

export function createElementImpl(tagName) {
    return function (document) {
        return function () {
            // Try-catch because createElement throws on empty string.
            try {
                return document.createElement(tagName)
            }
            catch {
                return null
            }
        }
    }
}

export function getElementByIdImpl(id) {
    return function (document) {
        return function () {
            return document.getElementById(id)
        }
    }
}

export function contentType(document) {
    return function () {
        return document.contentType
    }
}

export function referrer(document) {
    return function () {
        return document.referrer
    }
}

export function hasFocus(document) {
    return function () {
        return document.hasFocus()
    }
}

export function readyState(document) {
    return function () {
        return document.readState
    }
}
