export const _create = (notificationId) => (options) => () =>
    chrome.notifications.create(notificationId, options)

export const clear = (notificationId) => () => chrome.notifications.clear(notificationId)

export const getAll = () => () => chrome.notifications.getAll()

export const onClicked = chrome.notifications.onClicked

export const onButtonClicked = chrome.notifications.onButtonClicked

export const onClosed = chrome.notifications.onClosed
