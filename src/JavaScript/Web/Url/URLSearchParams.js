export function _new(params) {
    return function () {
        return new URLSearchParams(params)
    }
}

export function _get(key) {
    return function (params) {
        return function () {
            return params.get(key)
        }
    }
}

export function toString(params) {
    return function () {
        return params.toString()
    }
}
