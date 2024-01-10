export function x(rect) {
    return function () {
        return rect.x
    }
}

export function y(rect) {
    return function () {
        return rect.y
    }
}

export function width(rect) {
    return function () {
        return rect.width
    }
}

export function height(rect) {
    return function () {
        return rect.height
    }
}

export function top(rect) {
    return function () {
        return rect.top
    }
}

export function right(rect) {
    return function () {
        return rect.right
    }
}

export function bottom(rect) {
    return function () {
        return rect.bottom
    }
}

export function left(rect) {
    return function () {
        return rect.left
    }
}
