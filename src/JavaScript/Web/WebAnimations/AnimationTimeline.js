export function _currentTime(timeline) {
    return function () {
        return timeline.currentTime
    }
}
