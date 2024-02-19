export function write(data) {
    return function (clipboard) {
        return function () {
            return clipboard.write(data)
        }
    }
}
