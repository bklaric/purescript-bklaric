export const _addListener = (listener) => (filter) => (extraInfo) => (event) => () =>
    event.addListener(listener, filter, extraInfo)

export const onBeforeSendHeaders = chrome.webRequest.onBeforeSendHeaders

export const onBeforeRequest = chrome.webRequest.onBeforeRequest

export const onHeadersReceived = chrome.webRequest.onHeadersReceived

export const onCompleted = chrome.webRequest.onCompleted
