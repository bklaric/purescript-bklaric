export function _addListener(listener) {
    return function (filter) {
        return function (extraInfo) {
            return function (event) {
                return function () {
                    event.addListener(listener, filter, extraInfo)
                }
            }
        }
    }
}

export const onBeforeSendHeaders = chrome.webRequest.onBeforeSendHeaders

export const onBeforeRequest = chrome.webRequest.onBeforeRequest

export const onHeadersReceived = chrome.webRequest.onHeadersReceived

export const onCompleted = chrome.webRequest.onCompleted
