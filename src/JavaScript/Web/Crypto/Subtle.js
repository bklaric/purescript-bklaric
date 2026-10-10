export const _importKey = (format) => (keyData) => (algorithm) => (extractable) => (usages) => () =>
    crypto.subtle.importKey(format, keyData, algorithm, extractable, usages)

export const _verify = (algorithm) => (key) => (signature) => (data) => () =>
    crypto.subtle.verify(algorithm, key, signature, data)
