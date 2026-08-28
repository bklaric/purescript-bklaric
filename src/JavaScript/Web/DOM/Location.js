export const protocol = (location) => () => location.protocol

export const hostname = (location) => () => location.hostname

export const port = (location) => () => location.port

export const host = (location) => () => location.host

export const origin = (location) => () => location.origin

export const pathname = (location) => () => location.pathname

export const search = (location) => () => location.search

export const hash = (location) => () => location.hash

export const href = (location) => () => location.href

export const setHref = (href) => (location) => () => location.href = href

export const replace = (href) => (location) => () => location.replace(href)
