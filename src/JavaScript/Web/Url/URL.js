export function newImpl(left) {
    return function (right) {
        return function (url) {
            return function (base) {
                return function () {
                    try {
                        return right(new URL(url, base))
                    }
                    catch (error) {
                        return left(error)
                    }
                }
            }
        }
    }
}

export function protocol(url) {
    return function () {
        return url.protocol
    }
}

export function hostname(url) {
    return function () {
        return url.hostname
    }
}

export function port(url) {
    return function () {
        return url.port
    }
}

export function host(url) {
    return function () {
        return url.host
    }
}

export function origin(url) {
    return function () {
        return url.origin
    }
}

export function pathname(url) {
    return function () {
        return url.pathname
    }
}

export function search(url) {
    return function () {
        return url.search
    }
}

export function searchParams(url) {
    return function () {
        return url.searchParams
    }
}

export function hash(url) {
    return function () {
        return url.hash
    }
}

export function href(url) {
    return function () {
        return url.href
    }
}

export function setHref(href) {
    return function (url) {
        return function () {
            url.href = href
        }
    }
}
