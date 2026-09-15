export const _updateSessionRules = (options) => () => chrome.declarativeNetRequest.updateSessionRules(options)

export const _updateDynamicRules = (options) => () => chrome.declarativeNetRequest.updateDynamicRules(options)

export const _updateEnabledRulesets = (options) => () => chrome.declarativeNetRequest.updateEnabledRulesets(options)
