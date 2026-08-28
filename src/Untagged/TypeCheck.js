export const isInt = (x) => typeof(x) == "number" && ((x|0) === x)

export const getProperty = (name) => (x) => x[name]
