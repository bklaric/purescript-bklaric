export function _create(properties) {
    return function () {
        return new Promise((resolve, reject) => {
            const id = chrome.contextMenus.create(properties, () => {
                if (chrome.runtime.lastError) {
                    reject(new Error(chrome.runtime.lastError.message))
                }
                else {
                    resolve(id)
                }
            })
        })
    }
}

export function _update(id) {
    return function (properties) {
        return function () {
            return chrome.contextMenus.update(id, properties)
        }
    }
}

export function removeAll() {
    // chrome.contextMenus.removeAll that returns a promise is supported in Chrome 123 and later,
    // which is much too new for a lot of my current users.
    return new Promise((resolve, reject) => chrome.contextMenus.removeAll(() => {
        if (chrome.runtime.lastError) {
            reject(new Error(chrome.runtime.lastError.message))
        }
        else {
            resolve()
        }
    }))
}
