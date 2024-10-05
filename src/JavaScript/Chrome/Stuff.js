export function tabId(details) {
    return details.tabId
}

export function statusCode(details) {
    return details.statusCode
}

export function responseHeaders(details) {
    return details.responseHeaders
}

export function url(details) {
    return details.url
}

export function addOnHeadersReceivedListener(callback) {
    return function (filter) {
        return function (extraInfoSpec) {
            return function () {
                chrome.webRequest.onResponseStarted.addListener(function (details) {
                    callback(details)()
                }, filter, extraInfoSpec)
            }
        }
    }
}

export function insertCss(injection) {
    return function () {
        chrome.scripting.insertCSS(injection, function () { chrome.runtime.lastError })
    }
}

export function executeScript(injection) {
    return function () {
        chrome.scripting.executeScript(injection, function () { chrome.runtime.lastError })
    }
}

export function sendMessageToTab(tabId) {
    return function (message) {
        return function () {
            chrome.tabs.sendMessage(tabId, message, function () { })
        }
    }
}

export function getSessionObject(object) {
    return function (callback) {
        return function () {
            chrome.storage.session.get(object, function (data) {
                callback(data)()
            })
        }
    }
}

export function setSession(object) {
    return function (callback) {
        return function () {
            chrome.storage.session.set(object, callback)
        }
    }
}

export function getSyncObject(object) {
    return function (callback) {
        return function () {
            chrome.storage.sync.get(object, function (data) {
                callback(data)()
            })
        }
    }
}

export function setSync(object) {
    return function (callback) {
        return function () {
            chrome.storage.sync.set(object, callback)
        }
    }
}

export function getCurrentTab(callback) {
    return function () {
        chrome.tabs.getCurrent(function (tab) {
            callback(tab)()
        })
    }
}

export function showContextMenuItem(id) {
    return function () {
        chrome.contextMenus.update(id, { visible: true })
    }
}

export function hideContextMenuItem(id) {
    return function () {
        chrome.contextMenus.update(id, { visible: false })
    }
}

export function addOnInstalledListener() {
    chrome.runtime.onInstalled.addListener(function (details) {
        if (details.reason == "update") {
            chrome.storage.sync.get(["installTimestamp"], function (options) {
                if (!options.installTimestamp) {
                    chrome.storage.sync.set({
                        installTimestamp: new Date().toISOString().substring(0, 19) + "Z"
                    })
                }
            })
        }
        else if (details.reason == "install") {
            chrome.tabs.create({
                "url": `chrome://extensions/?options=${chrome.runtime.id}`
            });
            chrome.storage.sync.set({
                installTimestamp: new Date().toISOString().substring(0, 19) + "Z"
            })
        }
    })
}

export function onContextMenuClick(callback) {
    return function () {
        chrome.contextMenus.onClicked.addListener(function (info, tab) {
            callback(info)(tab)()
        })
    }
}

export function srcUrl(onClickData) {
    return onClickData.srcUrl
}

export function wakeUp() {
    chrome.webNavigation.onBeforeNavigate.addListener((details) => {
        console.log('wake me up');
    });
}
