export const _download = (options) => () => chrome.downloads.download(options)

export const _search = (query) => () => chrome.downloads.search(query)

export const pause = (downloadId) => () => chrome.downloads.pause(downloadId)

export const resume = (downloadId) => () => chrome.downloads.resume(downloadId)

export const cancel = (downloadId) => () => chrome.downloads.cancel(downloadId)

export const _getFileIcon = (downloadId) => (options) => () =>
    chrome.downloads.getFileIcon(downloadId, options)

export const open = (downloadId) => () => chrome.downloads.open(downloadId)

export const show = (downloadId) => () => chrome.downloads.show(downloadId)

export const showDefaultFolder = () => chrome.downloads.showDefaultFolder()

export const _erase = (query) => () => chrome.downloads.erase(query)

export const removeFile = (downloadId) => () => chrome.downloads.removeFile(downloadId)

export const acceptDanger = (downloadId) => () => chrome.downloads.acceptDanger(downloadId)

export const setShelfEnabled = (enabled) => () => chrome.downloads.setShelfEnabled(enabled)

export const onCreated = chrome.downloads.onCreated

export const onErased = chrome.downloads.onErased

export const onChanged = chrome.downloads.onChanged
