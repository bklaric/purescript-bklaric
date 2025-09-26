export function _getRecentlyClosed(filters) {
    return function () {
        return chrome.sessions.getRecentlyClosed(filters)
    }
}

export function restore(sessionId) {
    return function () {
        return chrome.sessions.restore(sessionId)
    }
}
