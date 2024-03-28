export function protocol(location) {
    return function () {
        return location.protocol
    }
}

export function hostname(location) {
    return function () {
        return location.hostname
    }
}

export function port(location) {
    return function () {
        return location.port
    }
}

export function host(location) {
    return function () {
        return location.host
    }
}

export function origin(location) {
    return function () {
        return location.origin
    }
}

export function pathname(location) {
    return function () {
        return location.pathname
    }
}

export function search(location) {
    return function () {
        return location.search
    }
}

export function hash(location) {
    return function () {
        return location.hash
    }
}

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
