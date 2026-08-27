export function timeout(milliseconds) {
    return function () {
        return AbortSignal.timeout(milliseconds)
    }
}
