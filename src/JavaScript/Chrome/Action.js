export const onClicked = chrome.action.onClicked

export const _setBadgeText = (details) => () => chrome.action.setBadgeText(details)

export const _clearBadgeText = (tabId) => () => chrome.action.setBadgeText({ tabId, text: null })

export const _setBadgeBackgroundColor = (details) => () => chrome.action.setBadgeBackgroundColor(details)

export const _setBadgeTextColor = (details) => () => chrome.action.setBadgeTextColor(details)

export const _setTitle = (details) => () => chrome.action.setTitle(details)
