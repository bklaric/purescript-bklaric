export const _querySelector = (selector) => (document) => () => document.querySelector(selector)

export const querySelectorAll = (selector) => (document) => () => document.querySelectorAll(selector)

export const _elementFromPoint = (x) => (y) => (document) => () => document.elementFromPoint(x, y)

export const elementsFromPoint = (x) => (y) => (document) => () => document.elementsFromPoint(x, y)

export const _head = (document) => () => document.head

export const body = (document) => () => document.body

export const _documentElement = (document) => () => document.documentElement

export const _createElement = (tagName) => (document) => () => {
    // Try-catch because createElement throws on empty string.
    try {
        // Outside an HTML document (an SVG or other XML document) createElement makes an
        // element in no namespace, which has no style and renders as nothing, so the
        // element is made in the XHTML namespace instead.
        return document instanceof HTMLDocument
            ? document.createElement(tagName)
            : document.createElementNS("http://www.w3.org/1999/xhtml", tagName)
    }
    catch {
        return null
    }
}

export const _getElementById = (id) => (document) => () => document.getElementById(id)

export const getElementsByClassName = (className) => (document) => () =>
    document.getElementsByClassName(className)

export const contentType = (document) => () => document.contentType

export const referrer = (document) => () => document.referrer

export const cookie = (document) => () => document.cookie

export const _activeElement = (document) => () => document.activeElement

export const hasFocus = (document) => () => document.hasFocus()

export const readyState = (document) => () => document.readyState

export const timeline = (document) => () => document.timeline
