export function _style(element) {
    return function () {
        return element.style
    }
}

export function _setStyle(inlineStyle) {
    return function (element) {
        return function () {
            element.style = inlineStyle
        }
    }
}
