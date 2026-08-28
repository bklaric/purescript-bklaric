export const value = (select) => () => select.value

export const setValue = (value) => (select) => () => select.value = value
