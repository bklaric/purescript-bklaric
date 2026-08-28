export const _style = (element) => () => element.style

export const _setStyle = (inlineStyle) => (element) => () => element.style = inlineStyle
