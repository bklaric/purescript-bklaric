export function getPropertyValue(property) {
    return function (style) {
        return function () {
            return style.getPropertyValue(property)
        }
    }
}

export function setProperty(property) {
    return function (value) {
        return function (style) {
            return function () {
                style.setProperty(property, value)
            }
        }
    }
}

export function removeProperty(property) {
    return function (style) {
        return function () {
            style.removeProperty(property)
        }
    }
}
