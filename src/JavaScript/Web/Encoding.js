export const encodeUtf8 = (string) => new TextEncoder().encode(string).buffer

export const _decodeBase64 = (left) => (right) => (string) => {
    try {
        return right(Uint8Array.from(atob(string), (character) => character.charCodeAt(0)).buffer)
    }
    catch (error) {
        return left(error)
    }
}
