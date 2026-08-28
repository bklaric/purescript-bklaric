export const _getRecentlyClosed = (filters) => () => chrome.sessions.getRecentlyClosed(filters)

export const restore = (sessionId) => () => chrome.sessions.restore(sessionId)
