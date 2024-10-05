export function getCurrent() {
    return chrome.tabs.getCurrent()
}

export function _sendMessage(extensionId) {
    return function (message) {
        return function (options) {
            return function () {
                return chrome.tabs.sendMessage(extensionId, message, options)
            }
        }
    }
}

export function _create(createProperties) {
    return function () {
        return chrome.tabs.create(createProperties)
    }
}

export function _update(tabId) {
    return function (updateProperties) {
        return function () {
            return chrome.tabs.update(tabId, updateProperties)
        }
    }
}

export function _query(queryProperties) {
    return function () {
        return chrome.tabs.query(queryProperties)
    }
}
