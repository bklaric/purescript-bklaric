export const _new = (left) => (right) => (locale) => (options) => () => {
    try {
        return right(new Intl.DateTimeFormat(locale, options))
    }
    catch (error) {
        return left(error)
    }
}

export const _newDefaultLocale = (options) => () => new Intl.DateTimeFormat(undefined, options)

export const new__ = () => new Intl.DateTimeFormat()

export const format = (date) => (dateTimeFormat) => dateTimeFormat.format(date)

export const resolvedOptions = (dateTimeFormat) => dateTimeFormat.resolvedOptions()
