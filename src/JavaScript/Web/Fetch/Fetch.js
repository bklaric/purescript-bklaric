export function _fetch(resource) {
    return function (options) {
        return function () {
            return fetch(resource, options)
        }
    }
}
