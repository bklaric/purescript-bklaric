export const _offsetWidth = (element) => () => element.offsetWidth

export const _offsetHeight = (element) => () => element.offsetHeight

export const _style = (element) => () => element.style

export const _setStyle = (inlineStyle) => (element) => () => element.style = inlineStyle

export const _click = (element) => () => element.click()

export const _blur = (element) => () => element.blur()

export const _focus = (options) => (element) => () => element.focus(options)
