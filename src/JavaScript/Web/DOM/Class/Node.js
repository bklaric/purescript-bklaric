export function parentElementImpl(node) {
    return function () {
        return node.parentElement
    }
}

export function appendChildDefault(child) {
    return function (node) {
        return function () {
            node.appendChild(child)
        }
    }
}

export function textContentDefault(node) {
    return function () {
        return node.textContent
    }
}

export function setTextContentDefault(string) {
    return function (node) {
        return function () {
            node.textContent = string
        }
    }
}

export function insertBeforeDefault(new_ ) {
    return function (reference) {
        return function (node) {
            return function () {
                node.insertBefore(new_, reference)
            }
        }
    }
}
