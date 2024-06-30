export function value(image) {
    return function () {
        return image.value
    }
}

export function setValue(value) {
    return function (image) {
        return function () {
            image.value = value
        }
    }
}
