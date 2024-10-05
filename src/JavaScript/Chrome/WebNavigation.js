export function toEventListener(listener) {
    return function () {
        return function (event) {
            return listener(event)()
        }
    }
}

export function onBeforeNavigateAddListener(listener) {
    return function () {
        chrome.webNavigation.onBeforeNavigate.addListener(listener)
    }
}

export function onCommittedAddListener(listener) {
    return function () {
        chrome.webNavigation.onCommitted.addListener(listener)
    }
}

export function onCompletedAddListener(listener) {
    return function () {
        chrome.webNavigation.onCompleted.addListener(listener)
    }
}

export function onHistoryStateUpdatedAddListener(listener) {
    return function () {
        chrome.webNavigation.onHistoryStateUpdated.addListener(listener)
    }
}
