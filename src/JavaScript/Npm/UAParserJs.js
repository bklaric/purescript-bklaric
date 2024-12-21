import { UAParser } from 'ua-parser-js'

function _new() {
    // Have to pass in navigator.userAgent manually
    // because it doesn't pick up the user agent correctly in service workers.
    return UAParser(navigator.userAgent)
}

export { _new as new }
