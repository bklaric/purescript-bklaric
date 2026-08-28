export const getSelf = (callback) => () => chrome.management.getSelf(function (info) { callback(info)() })
