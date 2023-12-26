export function userAgent(navigator) {
    return function () {
        return navigator.userAgent
    }
}

export function language(navigator) {
    return function () {
        return navigator.language
    }
}

export function languages(navigator) {
    return function () {
        return navigator.languages
    }
}
