import * as crypto from "crypto"

export const _hashHex = (algorithm) => (data) => (errorWrapper) => (successWrapper) => () => {
    try {
        return successWrapper(crypto.createHash(algorithm).update(data, "utf8").digest("hex"))
    }
    catch (error) {
        return errorWrapper(error)
    }
}

export const _randomBytes = (size) => (errorCallback) => (successCallback) => () =>
    crypto.randomBytes(size, function (error, buffer) {
        if (error) {
            errorCallback(error)()
        }
        else {
            successCallback(buffer)()
        }
    })

export const _randomBytesSync = (size) => (errorWrapper) => (successWrapper) => () => {
    try {
        return successWrapper(crypto.randomBytes(size))
    }
    catch (error) {
        return errorWrapper(error)
    }
}

export const _createCipheriv = (algorithm) => (key) => (iv) => (options) => (errorWrapper) => (successWrapper) => () => {
    try {
        return successWrapper(crypto.createCipheriv(algorithm, key, iv, options))
    }
    catch (error) {
        return errorWrapper(error)
    }
}

export const _createDecipheriv = (algorithm) => (key) => (iv) => (options) => (errorWrapper) => (successWrapper) => () => {
    try {
        return successWrapper(crypto.createDecipheriv(algorithm, key, iv, options))
    }
    catch (error) {
        return errorWrapper(error)
    }
}

export const _update = (data) => (inputEncoding) => (cipher) => (errorWrapper) => (successWrapper) => () => {
    try {
        return successWrapper(cipher.update(data, inputEncoding))
    }
    catch (error) {
        return errorWrapper(error)
    }
}

export const _final = (cipher) => (errorWrapper) => (successWrapper) => () => {
    try {
        return successWrapper(cipher.final())
    }
    catch (error) {
        return errorWrapper(error)
    }
}

export const _getAuthTag = (cipher) => (errorWrapper) => (successWrapper) => () => {
    try {
        return successWrapper(cipher.getAuthTag())
    }
    catch (error) {
        return errorWrapper(error)
    }
}

export const _setAuthTag = (authTag) => (decipher) => (errorWrapper) => (successWrapper) => () => {
    try {
        decipher.setAuthTag(authTag)
        return successWrapper({})
    }
    catch (error) {
        return errorWrapper(error)
    }
}
