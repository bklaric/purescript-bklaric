export function src(iframe) {
    return function () {
        return iframe.src
    }
}

export function setSrc(src) {
    return function (iframe) {
        return function () {
            iframe.src = src
        }
    }
}
