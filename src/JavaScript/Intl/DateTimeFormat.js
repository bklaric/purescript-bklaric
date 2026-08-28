export const _new = (locale) => (options) => new Intl.DateTimeFormat(locale, options)

export const format = (date) => (dateTimeFormat) => dateTimeFormat.format(date)
