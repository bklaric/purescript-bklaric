export function _isConnected(node) {
    return function () {
        return node.isConnected
    }
}

export function _parentElement(node) {
    return function () {
        return node.parentElement
    }
}

export function _appendChild(child) {
    return function (node) {
        return function () {
            node.appendChild(child)
        }
    }
}

export function _textContent(node) {
    return function () {
        return node.textContent
    }
}

export function _setTextContent(string) {
    return function (node) {
        return function () {
            node.textContent = string
        }
    }
}

export function _insertBefore(new_ ) {
    return function (reference) {
        return function (node) {
            return function () {
                node.insertBefore(new_, reference)
            }
        }
    }
}
