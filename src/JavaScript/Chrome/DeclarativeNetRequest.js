export const _updateSessionRules = (options) => () => chrome.declarativeNetRequest.updateSessionRules(options)

export const _updateDynamicRules = (options) => () => chrome.declarativeNetRequest.updateDynamicRules(options)
