export function status(response) {
    return response.status
}

export function text(response) {
    return function () {
        return response.text()
    }
}

export function json(response) {
    return function () {
        return response.json()
    }
}

export function blob(response) {
    return function () {
        return response.blob()
    }
}

export function arrayBuffer(response) {
    return function () {
        return response.arrayBuffer()
    }
}

export function ok(response) {
    return response.ok
}

export function statusText(response) {
    return response.statusText
}
