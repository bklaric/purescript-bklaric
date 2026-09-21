export const _new = (init) => () => new Headers(init)

export const set = (name) => (value) => (headers) => () => headers.set(name, value)
