export const width = (image) => () => image.width

export const setWidth = (width) => (image) => () => image.width = width

export const height = (image) => () => image.height

export const setHeight = (height) => (image) => () => image.height = height

export const src = (image) => () => image.src

export const setSrc = (src) => (image) => () => image.src = src

export const currentSrc = (image) => () => image.currentSrc

export const srcset = (image) => () => image.srcset

export const setSrcset = (srcset) => (image) => () => image.srcset = srcset

export const crossOrigin = (image) => () => image.crossOrigin

export const setCrossOrigin = (crossOrigin) => (image) => () => image.crossOrigin = crossOrigin

export const naturalWidth = (image) => () => image.naturalWidth

export const naturalHeight = (image) => () => image.naturalHeight

export const complete = (image) => () => image.complete
