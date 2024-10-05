export function _sendMessage(extensionId) {
    return function (message) {
        return function (options) {
            return function () {
                return chrome.runtime.sendMessage(extensionId, message, options)
            }
        }
    }
}

export function openOptionsPage() {
    return chrome.runtime.openOptionsPage()
}

export function getManifest() {
    return chrome.runtime.getManifest()
}

export function id() {
    return chrome.runtime.id
}

export function getURL(path) {
    return function () {
        return chrome.runtime.getURL(path)
    }
}

export function setUninstallURL(url) {
    return function () {
        return chrome.runtime.setUninstallURL(url)
    }
}

export function reload() {
    return chrome.runtime.reload()
}

export const onMessage = chrome.runtime.onMessage

export const onSuspend = chrome.runtime.onSuspend

export const onUpdateAvailable = chrome.runtime.onUpdateAvailable

export const onInstalled = chrome.runtime.onInstalled
