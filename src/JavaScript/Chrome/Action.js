export function onClickedAddListener(listener) {
    return function () {
        chrome.action.onClicked.addListener(function (tab) {
            listener(tab)()
        })
    }
}

export function setBadgeTextImpl(details) {
    return function (callback) {
        return function () {
            chrome.action.setBadgeText(details, callback)
        }
    }
}
