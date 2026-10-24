export const href = (image) => () => image.href

export const setHref = (value) => (image) => () => image.href = value

export const setDownload = (value) => (anchor) => () => anchor.download = value
