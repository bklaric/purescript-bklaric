export function _executeScript(injection) {
    return function () {
        return chrome.scripting.executeScript(injection)
    }
}
