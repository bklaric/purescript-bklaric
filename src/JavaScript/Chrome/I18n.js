export const _getMessage = (messageName) => (substitutions) => (options) => () => {
    // Firefox doesn't support the options parameter and throws if it's passed.
    if (options !== undefined) {
        return chrome.i18n.getMessage(messageName, substitutions, options)
    }
    return chrome.i18n.getMessage(messageName, substitutions)
}

export const getUILanguage = () => chrome.i18n.getUILanguage()
