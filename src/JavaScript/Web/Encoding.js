export const encodeUtf8 = (string) => new TextEncoder().encode(string).buffer

// Uint8Array.prototype.toBase64 where the browser has it. Otherwise btoa, which takes a binary
// string, built in chunks: spreading a multi-megabyte buffer into a single String.fromCharCode
// call overflows the call stack.
export const encodeBase64 = (arrayBuffer) => {
    const bytes = new Uint8Array(arrayBuffer)
    if (typeof bytes.toBase64 === 'function') {
        return bytes.toBase64()
    }
    const chunkSize = 0x8000
    let binary = ''
    for (let start = 0; start < bytes.length; start += chunkSize) {
        binary += String.fromCharCode(...bytes.subarray(start, start + chunkSize))
    }
    return btoa(binary)
}

// Uint8Array.fromBase64 where the browser has it, which decodes natively rather than through a
// callback per character.
export const _decodeBase64 = (left) => (right) => (string) => {
    try {
        return right(typeof Uint8Array.fromBase64 === 'function'
            ? Uint8Array.fromBase64(string).buffer
            : Uint8Array.from(atob(string), (character) => character.charCodeAt(0)).buffer)
    }
    catch (error) {
        return left(error)
    }
}
