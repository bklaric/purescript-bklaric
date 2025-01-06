export function _getMessage(messageName) {
    return function (substitutions) {
        return function (options) {
            return function () {
                return chrome.i18n.getMessage(messageName, substitutions, options)
            }
        }
    }
}
