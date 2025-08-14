export function _download(options) {
    return function () {
        return chrome.downloads.download(options)
    }
}

export function _search(query) {
    return function () {
        return chrome.downloads.search(query)
    }
}

export function pause(downloadId) {
    return function () {
        return chrome.downloads.pause(downloadId)
    }
}

export function resume(downloadId) {
    return function () {
        return chrome.downloads.resume(downloadId)
    }
}

export function cancel(downloadId) {
    return function () {
        return chrome.downloads.cancel(downloadId)
    }
}

export function _getFileIcon(downloadId) {
    return function (options) {
        return function () {
            return chrome.downloads.getFileIcon(downloadId, options)
        }
    }
}

export function open(downloadId) {
    return function () {
        return chrome.downloads.open(downloadId)
    }
}

export function show(downloadId) {
    return function () {
        return chrome.downloads.show(downloadId)
    }
}

export const showDefaultFolder = function () {
    return chrome.downloads.showDefaultFolder()
}

export function _erase(query) {
    return function () {
        return chrome.downloads.erase(query)
    }
}

export function removeFile(downloadId) {
    return function () {
        return chrome.downloads.removeFile(downloadId)
    }
}

export function acceptDanger(downloadId) {
    return function () {
        return chrome.downloads.acceptDanger(downloadId)
    }
}

export function setShelfEnabled(enabled) {
    return function () {
        return chrome.downloads.setShelfEnabled(enabled)
    }
}

export const onCreated = chrome.downloads.onCreated

export const onErased = chrome.downloads.onErased

export const onChanged = chrome.downloads.onChanged
