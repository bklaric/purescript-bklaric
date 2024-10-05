export const onClicked = chrome.action.onClicked

export function setBadgeTextImpl(details) {
    return function (callback) {
        return function () {
            chrome.action.setBadgeText(details, callback)
        }
    }
}
