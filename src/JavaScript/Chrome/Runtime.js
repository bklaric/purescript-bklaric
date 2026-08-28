export const _sendMessage = (extensionId) => (message) => (options) => () =>
    chrome.runtime.sendMessage(extensionId, message, options)

export const openOptionsPage = () => chrome.runtime.openOptionsPage()

export const getManifest = () => chrome.runtime.getManifest()

export const id = () => chrome.runtime.id

export const getURL = (path) => () => chrome.runtime.getURL(path)

export const setUninstallURL = (url) => () => chrome.runtime.setUninstallURL(url)

export const reload = () => chrome.runtime.reload()

export const onMessage = chrome.runtime.onMessage

export const onSuspend = chrome.runtime.onSuspend

export const onUpdateAvailable = chrome.runtime.onUpdateAvailable

export const onInstalled = chrome.runtime.onInstalled
