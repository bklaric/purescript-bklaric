// Firefox documents alarms.create as returning nothing rather than a promise.
export const _create = (name) => (info) => () => Promise.resolve(chrome.alarms.create(name, info))

export const _get = (name) => () => chrome.alarms.get(name)

export const onAlarm = chrome.alarms.onAlarm
