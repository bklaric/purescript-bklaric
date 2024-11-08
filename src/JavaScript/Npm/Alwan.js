import Alwan from 'alwan';

export function _new(reference) {
    return function (config) {
        return function () {
            return new Alwan(reference, config)
        }
    }
}

export function _on(event) {
    return function (callback) {
        return function (alwan) {
            return function () {
                alwan.on(event, ev => callback(ev)())
            }
        }
    }
}
