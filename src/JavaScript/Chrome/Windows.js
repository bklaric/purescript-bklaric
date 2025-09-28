export function _create(createData) {
    return function () {
        return chrome.windows.create(createData)
    }
}

export function _get(windowId) {
    return function (getInfo) {
        return function () {
            return chrome.windows.get(windowId, getInfo)
        }
    }
}

export function _getAll(getInfo) {
    return function () {
        return chrome.windows.getAll(getInfo)
    }
}
