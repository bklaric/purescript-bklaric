export function tabImpl(messageSender) {
    return function () {
        return messageSender.tab
    }
}
