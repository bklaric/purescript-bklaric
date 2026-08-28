export const getPropertyValue = (property) => (style) => () => style.getPropertyValue(property)

export const setProperty = (property) => (value) => (style) => () => style.setProperty(property, value)

export const removeProperty = (property) => (style) => () => style.removeProperty(property)

export const cssText = (style) => () => style.cssText
