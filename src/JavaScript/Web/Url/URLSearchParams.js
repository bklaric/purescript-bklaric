export function empty() {
    return new URLSearchParams()
}

export function fromString(string) {
    return function () {
        return new URLSearchParams(string)
    }
}

export function fromObject(object) {
    return function () {
        return new URLSearchParams(object)
    }
}

export function getImpl(key) {
    return function (params) {
        return function () {
            return params.get(key)
        }
    }
}
