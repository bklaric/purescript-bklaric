export const toEventListener = (listener) => () => (event) => listener(event)()

export const onBeforeNavigateAddListener = (listener) => () =>
    chrome.webNavigation.onBeforeNavigate.addListener(listener)

export const onCommittedAddListener = (listener) => () =>
    chrome.webNavigation.onCommitted.addListener(listener)

export const onCompletedAddListener = (listener) => () =>
    chrome.webNavigation.onCompleted.addListener(listener)

export const onHistoryStateUpdatedAddListener = (listener) => () =>
    chrome.webNavigation.onHistoryStateUpdated.addListener(listener)
