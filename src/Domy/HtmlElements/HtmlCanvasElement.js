export function width(canvas) {
    return function () {
        return canvas.width
    }
}

export function height(canvas) {
    return function () {
        return canvas.height
    }
}

export function setWidth(width) {
    return function (canvas) {
        return function () {
            canvas.width = width
        }
    }
}

export function setHeight(height) {
    return function (canvas) {
        return function () {
            canvas.height = height
        }
    }
}

export function toBlob(callback) {
    return function (canvas) {
        return function () {
            canvas.toBlob(blob => callback(blob)())
        }
    }
}

export function getContext2D(canvas) {
    return function () {
        return canvas.getContext('2d')
    }
}

export function getContextBitmapRendering(canvas) {
    return function () {
        return canvas.getContext('bitmaprenderer')
    }
}

export function drawImage(image) {
    return function (dx) {
        return function (dy) {
            return function (context) {
                return function () {
                    context.drawImage(image, dx, dy)
                }
            }
        }
    }
}

export function createImageBitmapImpl(image) {
    return function () {
        return createImageBitmap(image)
    }
}
