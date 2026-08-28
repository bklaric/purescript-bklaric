import { UAParser } from 'ua-parser-js'

const _new = () => {
    // Have to pass in navigator.userAgent manually
    // because it doesn't pick up the user agent correctly in service workers.
    return UAParser(navigator.userAgent)
}

export { _new as new }

export const parse = (userAgent) => UAParser(userAgent)
