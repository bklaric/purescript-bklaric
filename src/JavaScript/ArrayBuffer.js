export const byteLength = (arrayBuffer) => arrayBuffer.byteLength

export const takeBytes = (count) => (arrayBuffer) => {
    const length = Math.min(count, arrayBuffer.byteLength)
    return Array.from(new Uint8Array(arrayBuffer, 0, length))
}
