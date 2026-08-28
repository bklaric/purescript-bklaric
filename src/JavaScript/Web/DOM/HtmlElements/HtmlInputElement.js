export const value = (image) => () => image.value

export const setValue = (value) => (image) => () => image.value = value
