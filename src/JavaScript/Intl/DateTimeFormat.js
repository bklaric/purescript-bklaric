export function _new(locale) {
    return function (options) {
        return new Intl.DateTimeFormat(locale, options)
    }
}

export function format(date) {
    return function (dateTimeFormat) {
        return dateTimeFormat.format(date)
    }
}
