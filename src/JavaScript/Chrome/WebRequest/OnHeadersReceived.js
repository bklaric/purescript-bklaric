export function onHeadersReceivedAddListenerImpl(callback) {
    return function (filter) {
        return function (extraInfoSpec) {
            return function () {
                chrome.webRequest.onHeadersReceived.addListener(function (details) {
                    callback(details)()
                }, filter, extraInfoSpec)
            }
        }
    }
}
