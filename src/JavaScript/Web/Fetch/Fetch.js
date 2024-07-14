export function _fetch(resource) {
    return function (options) {
        return function () {
            return self.fetch(resource, options)
        }
    }
}
