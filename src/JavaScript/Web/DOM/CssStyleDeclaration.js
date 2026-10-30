export const getPropertyValue = (property) => (style) => () => style.getPropertyValue(property)

export const getPropertyPriority = (property) => (style) => () => style.getPropertyPriority(property)

export const setProperty = (property) => (value) => (priority) => (style) => () => style.setProperty(property, value, priority)

export const setProperty_ = (property) => (value) => (style) => () => style.setProperty(property, value)

export const removeProperty = (property) => (style) => () => style.removeProperty(property)

export const cssText = (style) => () => style.cssText
