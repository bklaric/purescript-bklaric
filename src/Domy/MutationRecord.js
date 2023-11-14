export function typeString(record) {
    return function () {
        return record.type
    }
}

export function target(record) {
    return function () {
        return record.target
    }
}

export function addedNodes(record) {
    return function () {
        return record.addedNodes
    }
}

export function removedNodes(record) {
    return function () {
        return record.removedNodes
    }
}

export function _nextSibling(record) {
    return function () {
        return record.nextSibling
    }
}

export function _previousSibling(record) {
    return function () {
        return record.previousSibling
    }
}

export function _attributeName(record) {
    return function () {
        return record.attributeName
    }
}

export function _attributeNamespace(record) {
    return function () {
        return record.attributeNamespace
    }
}

export function _oldValue(record) {
    return function () {
        return record.oldValue
    }
}
