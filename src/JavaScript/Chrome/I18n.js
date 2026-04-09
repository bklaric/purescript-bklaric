export function _getMessage(messageName) {
    return function (substitutions) {
        return function (options) {
            return function () {
                // Firefox doesn't support the options parameter and throws if it's passed.
                if (options !== undefined) {
                    return chrome.i18n.getMessage(messageName, substitutions, options)
                }
                return chrome.i18n.getMessage(messageName, substitutions)
            }
        }
    }
}

export function getUILanguage() {
    return chrome.i18n.getUILanguage()
}
