export const _readDate = (value) => value instanceof Date ? value : null

export const now = () => new Date()

export const _localDate = (year) => (month) => (day) => new Date(year, month, day)

export const toISOString = (date) => () => date.toISOString()

export const getTime = (date) => date.getTime()

export const getUTCFullYear = (date) => date.getUTCFullYear()

export const getUTCMonth = (date) => date.getUTCMonth()

export const getUTCDate = (date) => date.getUTCDate()
