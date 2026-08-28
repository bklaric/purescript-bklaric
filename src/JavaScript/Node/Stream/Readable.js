export const defaultReadableHighWaterMark = (readable) => () => readable.readableHighWaterMark

export const defaultReadableLength = (readable) => () => readable.readableLength

export const defaultIsPaused = (readable) => () => readable.isPaused()

export const _defaultRead = (size) => (readable) => () => readable.read(size)

export const defaultResume = (readable) => () => readable.resume()

export const defaultPause = (readable) => () => readable.pause()

export const defaultPipe = (writable) => (end) => (readable) => () => readable.pipe(writable, end)

export const defaultUnpipe = (writable) => (readable) => () => readable.unpipe(writable)

export const _defaultSetEncoding = (encoding) => (readable) => () => readable.setEncoding(encoding)

export const defaultUnshift = (chunk) => (readable) => () => readable.unshift(chunk)

export const defaultDestroy = (error) => (readable) => () => readable.destroy(error)
