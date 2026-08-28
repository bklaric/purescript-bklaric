export const _create = (properties) => () =>
    new Promise((resolve, reject) => {
        const id = chrome.contextMenus.create(properties, () => {
            if (chrome.runtime.lastError) {
                reject(new Error(chrome.runtime.lastError.message))
            }
            else {
                resolve(id)
            }
        })
    })

export const _update = (id) => (properties) => () => chrome.contextMenus.update(id, properties)

export const _remove = (id) => () => chrome.contextMenus.remove(id)

export const removeAll = () => {
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
