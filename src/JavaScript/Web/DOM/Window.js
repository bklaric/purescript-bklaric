export const parent = (window) => () => window.parent

export const top = (window) => () => window.top

export const document = (window) => () => window.document

export const location = (window) => () => window.location

export const navigator = (window) => () => window.navigator

export const localStorage = (window) => () => window.localStorage

export const innerWidth = (window) => () => window.innerWidth

export const innerHeight = (window) => () => window.innerHeight

export const scrollBy = (x) => (y) => (window) => () => window.scrollBy(x, y)

export const open = (url) => (target) => (features) => (window) => () => window.open(url, target, features)

export const close = (window) => () => window.close()

export const _getComputedStyle = (element) => (pseudoElement) => (window) => () =>
    window.getComputedStyle(element, pseudoElement)

export const requestAnimationFrame = (callback) => (window) => () =>
    window.requestAnimationFrame((timestamp) => { callback(timestamp)() })
