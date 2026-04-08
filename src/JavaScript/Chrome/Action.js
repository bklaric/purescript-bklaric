export const onClicked = chrome.action.onClicked

export function setBadgeTextImpl(details) {
    return function () {
        return chrome.action.setBadgeText(details)
    }
}
