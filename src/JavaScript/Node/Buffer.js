import * as Buffer from "buffer"

export const _alloc = (size) => (fill) => (encoding) => () => Buffer.Buffer.alloc(size, fill, encoding)

export const _fromString = (string) => (encoding) => () => Buffer.Buffer.from(string, encoding)

export const fromArrayBuffer = (arrayBuffer) => () => Buffer.Buffer.from(arrayBuffer)

export const concat = (buffers) => (totalLength) => () => Buffer.Buffer.concat(buffers, totalLength)

export const _toString = (encoding) => (start) => (end) => (buffer) => () =>
    buffer.toString(encoding, start, end)

export const length = (buffer) => () => buffer.length

export const subarray = (start) => (end) => (buffer) => () => buffer.subarray(start, end)
