export const fonts = (document) => () => document.fonts

export const load = (font) => (fontFaceSet) => () => fontFaceSet.load(font).then(() => undefined)
