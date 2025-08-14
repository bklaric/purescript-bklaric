export function id(downloadItem) {
    return function () {
        return downloadItem.id
    }
}

export function url(downloadItem) {
    return function () {
        return downloadItem.url
    }
}

export function finalUrl(downloadItem) {
    return function () {
        return downloadItem.finalUrl
    }
}

export function referrer(downloadItem) {
    return function () {
        return downloadItem.referrer
    }
}

export function filename(downloadItem) {
    return function () {
        return downloadItem.filename
    }
}

export function incognito(downloadItem) {
    return function () {
        return downloadItem.incognito
    }
}

export function danger(downloadItem) {
    return function () {
        return downloadItem.danger
    }
}

export function mime(downloadItem) {
    return function () {
        return downloadItem.mime
    }
}

export function startTime(downloadItem) {
    return function () {
        return downloadItem.startTime
    }
}

export function _endTime(downloadItem) {
    return function () {
        return downloadItem.endTime
    }
}

export function _estimatedEndTime(downloadItem) {
    return function () {
        return downloadItem.estimatedEndTime
    }
}

export function state(downloadItem) {
    return function () {
        return downloadItem.state
    }
}

export function paused(downloadItem) {
    return function () {
        return downloadItem.paused
    }
}

export function canResume(downloadItem) {
    return function () {
        return downloadItem.canResume
    }
}

export function _error(downloadItem) {
    return function () {
        return downloadItem.error
    }
}

export function bytesReceived(downloadItem) {
    return function () {
        return downloadItem.bytesReceived
    }
}

export function totalBytes(downloadItem) {
    return function () {
        return downloadItem.totalBytes
    }
}

export function fileSize(downloadItem) {
    return function () {
        return downloadItem.fileSize
    }
}

export function exists(downloadItem) {
    return function () {
        return downloadItem.exists
    }
}
