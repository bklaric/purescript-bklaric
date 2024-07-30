export function width(image) {
    return function () {
        return image.width
    }
}

export function setWidth(width) {
    return function (image) {
        return function () {
            image.width = width
        }
    }
}

export function height(image) {
    return function () {
        return image.height
    }
}

export function setHeight(height) {
    return function (image) {
        return function () {
            image.height = height
        }
    }
}

export function src(image) {
    return function () {
        return image.src
    }
}

export function setSrc(src) {
    return function (image) {
        return function () {
            image.src = src
        }
    }
}

export function srcset(image) {
    return function () {
        return image.srcset
    }
}

export function setSrcset(srcset) {
    return function (image) {
        return function () {
            image.srcset = srcset
        }
    }
}

export function naturalWidth(image) {
    return function () {
        return image.naturalWidth
    }
}

export function naturalHeight(image) {
    return function () {
        return image.naturalHeight
    }
}

export function complete(image) {
    return function () {
        return image.complete
    }
}
