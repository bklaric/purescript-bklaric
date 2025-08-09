export function _create(notificationId) {
    return function (options) {
        return function () {
            return chrome.notifications.create(notificationId, options)
        }
    }
}

export function clear(notificationId) {
    return function () {
        return chrome.notifications.clear(notificationId)
    }
}

export function getAll() {
    return function () {
        return chrome.notifications.getAll()
    }
}

export const onClicked = chrome.notifications.onClicked

export const onButtonClicked = chrome.notifications.onButtonClicked

export const onClosed = chrome.notifications.onClosed
