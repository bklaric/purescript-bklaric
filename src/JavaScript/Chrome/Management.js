export function getSelf(callback) {
    return function () {
        chrome.management.getSelf(function (info) {
            callback(info)()
        })
    }
}
