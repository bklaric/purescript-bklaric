export const _create = (createData) => () => chrome.windows.create(createData)

export const _get = (windowId) => (getInfo) => () => chrome.windows.get(windowId, getInfo)

export const _getAll = (getInfo) => () => chrome.windows.getAll(getInfo)

export const getLastFocused_ = () => chrome.windows.getLastFocused()
