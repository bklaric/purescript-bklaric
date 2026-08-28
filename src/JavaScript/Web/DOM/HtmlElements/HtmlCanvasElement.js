export const width = (canvas) => () => canvas.width

export const height = (canvas) => () => canvas.height

export const setWidth = (width) => (canvas) => () => canvas.width = width

export const setHeight = (height) => (canvas) => () => canvas.height = height

export const _toBlob = (left) => (right) => (callback) => (canvas) => () => {
    try {
        canvas.toBlob(blob => {
            callback(right(blob))()
        })
    } catch (error) {
        callback(left(error))()
    }
}

export const _getContext2D = (canvas) => () => canvas.getContext('2d')

export const getContextBitmapRendering = (canvas) => () => canvas.getContext('bitmaprenderer')

export const drawImage = (image) => (dx) => (dy) => (context) => () => context.drawImage(image, dx, dy)

export const _createImageBitmap = (image) => () => createImageBitmap(image)
