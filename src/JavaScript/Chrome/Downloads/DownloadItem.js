export const id = (downloadItem) => () => downloadItem.id

export const url = (downloadItem) => () => downloadItem.url

export const finalUrl = (downloadItem) => () => downloadItem.finalUrl

export const referrer = (downloadItem) => () => downloadItem.referrer

export const filename = (downloadItem) => () => downloadItem.filename

export const incognito = (downloadItem) => () => downloadItem.incognito

export const danger = (downloadItem) => () => downloadItem.danger

export const mime = (downloadItem) => () => downloadItem.mime

export const startTime = (downloadItem) => () => downloadItem.startTime

export const _endTime = (downloadItem) => () => downloadItem.endTime

export const _estimatedEndTime = (downloadItem) => () => downloadItem.estimatedEndTime

export const state = (downloadItem) => () => downloadItem.state

export const paused = (downloadItem) => () => downloadItem.paused

export const canResume = (downloadItem) => () => downloadItem.canResume

export const _error = (downloadItem) => () => downloadItem.error

export const bytesReceived = (downloadItem) => () => downloadItem.bytesReceived

export const totalBytes = (downloadItem) => () => downloadItem.totalBytes

export const fileSize = (downloadItem) => () => downloadItem.fileSize

export const exists = (downloadItem) => () => downloadItem.exists
