export const defaultWritableHighWaterMark = (stream) => stream.writableHighWaterMark

export const defaultWritableLength = (stream) => stream.writableLength

export const defaultCork = (stream) => () => stream.cork()

export const defaultUncork = (stream) => () => stream.uncork()

export const defaultWrite = (toWrite) => (callback) => (stream) => () => stream.write(toWrite, callback)

export const defaultEnd = (toWrite) => (callback) => (stream) => () => stream.end(toWrite, callback)

export const defaultDestroy = (error) => (stream) => () => stream.destroy(error)
