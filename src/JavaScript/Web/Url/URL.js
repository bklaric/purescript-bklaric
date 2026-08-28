export const _new = (left) => (right) => (url) => (base) => () => {
    try {
        return right(new URL(url, base))
    }
    catch (error) {
        return left(error)
    }
}

export const protocol = (url) => () => url.protocol

export const hostname = (url) => () => url.hostname

export const port = (url) => () => url.port

export const host = (url) => () => url.host

export const origin = (url) => () => url.origin

export const pathname = (url) => () => url.pathname

export const search = (url) => () => url.search

export const searchParams = (url) => () => url.searchParams

export const hash = (url) => () => url.hash

export const href = (url) => () => url.href

export const setHref = (href) => (url) => () => url.href = href

export const createObjectURL = (obj) => () => URL.createObjectURL(obj)

export const toString = (url) => () => url.toString()
