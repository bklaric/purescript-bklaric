export function byteLength(arrayBuffer) {
    return arrayBuffer.byteLength
}

export function takeBytes(count) {
    return function (arrayBuffer) {
        const length = Math.min(count, arrayBuffer.byteLength)
        return Array.from(new Uint8Array(arrayBuffer, 0, length))
    }
}
