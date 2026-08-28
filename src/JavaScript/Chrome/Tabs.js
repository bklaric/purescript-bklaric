export const _sendMessage = (extensionId) => (message) => (options) => () =>
    chrome.tabs.sendMessage(extensionId, message, options)

export const get = (tabId) => () => chrome.tabs.get(tabId)

export const getCurrent = () => chrome.tabs.getCurrent()


export const _create = (createProperties) => () => chrome.tabs.create(createProperties)

export const _update = (tabId) => (updateProperties) => () => chrome.tabs.update(tabId, updateProperties)

export const _query = (queryProperties) => () => chrome.tabs.query(queryProperties)

export const onCreated = chrome.tabs.onCreated

export const onUpdated = chrome.tabs.onUpdated

export const onRemoved = chrome.tabs.onRemoved

export const onMoved = chrome.tabs.onMoved
