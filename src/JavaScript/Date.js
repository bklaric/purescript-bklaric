export const readDateImpl = (value) => value instanceof Date ? value : null

export function toISOString(date) {
    return function () {
        return date.toISOString()
    }
}

export const getTime = (date) => date.getTime()

export const getUTCFullYear = (date) => date.getUTCFullYear()

export const getUTCMonth = (date) => date.getUTCMonth()

export const getUTCDate = (date) => date.getUTCDate()
