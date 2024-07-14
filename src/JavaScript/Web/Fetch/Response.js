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
