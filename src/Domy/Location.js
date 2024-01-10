export function href(location) {
    return function () {
        return location.href
    }
}

export function setHref(href) {
    return function (location) {
        return function () {
            location.href = href
        }
    }
}
