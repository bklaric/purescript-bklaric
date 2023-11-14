export function setProperty(property) {
    return function (value) {
        return function (style) {
            return function () {
                style[property] = value
                return {}
            }
        }
    }
}
