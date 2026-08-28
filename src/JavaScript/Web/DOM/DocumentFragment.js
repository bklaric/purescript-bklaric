export const _querySelector = (selector) => (documentFragment) => () =>
    documentFragment.querySelector(selector)

export const _querySelectorAll = (selector) => (documentFragment) => () =>
    documentFragment.querySelectorAll(selector)
