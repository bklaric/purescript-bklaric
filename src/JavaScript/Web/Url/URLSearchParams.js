export const _new = (params) => () => new URLSearchParams(params)

export const _get = (key) => (params) => () => params.get(key)

export const set = (key) => (value) => (params) => () => params.set(key, value)

export const toString = (params) => () => params.toString()
