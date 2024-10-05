export function onResponseStartedAddListenerImpl(callback) {
    return function (filter) {
        return function (extraInfoSpec) {
            return function () {
                chrome.webRequest.onResponseStarted.addListener(function (details) {
                    callback(details)()
                }, filter, extraInfoSpec)
            }
        }
    }
}
