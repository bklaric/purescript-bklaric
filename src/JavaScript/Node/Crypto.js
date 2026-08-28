import * as crypto from "crypto"

export const randomBytesImpl = function (size) {
    return function (errorCallback) {
        return function (successCallback) {
            return function () {
                crypto.randomBytes(size, function (error, buffer) {
                    if (error) {
                        errorCallback(error)()
                    }
                    else {
                        successCallback(buffer)()
                    }
                })
            }
        }
    }
}

export const randomBytesSyncImpl = function (size) {
    return function (errorWrapper) {
        return function (successWrapper) {
            return function () {
                try {
                    return successWrapper(crypto.randomBytes(size))
                }
                catch (error) {
                    return errorWrapper(error)
                }
            }
        }
    }
}

export const createCipherivImpl = function (algorithm) {
    return function (key) {
        return function (iv) {
            return function (options) {
                return function (errorWrapper) {
                    return function (successWrapper) {
                        return function () {
                            try {
                                return successWrapper(crypto.createCipheriv(algorithm, key, iv, options))
                            }
                            catch (error) {
                                return errorWrapper(error)
                            }
                        }
                    }
                }
            }
        }
    }
}

export const createDecipherivImpl = function (algorithm) {
    return function (key) {
        return function (iv) {
            return function (options) {
                return function (errorWrapper) {
                    return function (successWrapper) {
                        return function () {
                            try {
                                return successWrapper(crypto.createDecipheriv(algorithm, key, iv, options))
                            }
                            catch (error) {
                                return errorWrapper(error)
                            }
                        }
                    }
                }
            }
        }
    }
}

export const updateImpl = function (data) {
    return function (inputEncoding) {
        return function (cipher) {
            return function (errorWrapper) {
                return function (successWrapper) {
                    return function () {
                        try {
                            return successWrapper(cipher.update(data, inputEncoding))
                        }
                        catch (error) {
                            return errorWrapper(error)
                        }
                    }
                }
            }
        }
    }
}

export const finalImpl = function (cipher) {
    return function (errorWrapper) {
        return function (successWrapper) {
            return function () {
                try {
                    return successWrapper(cipher.final())
                }
                catch (error) {
                    return errorWrapper(error)
                }
            }
        }
    }
}

export const getAuthTagImpl = function (cipher) {
    return function (errorWrapper) {
        return function (successWrapper) {
            return function () {
                try {
                    return successWrapper(cipher.getAuthTag())
                }
                catch (error) {
                    return errorWrapper(error)
                }
            }
        }
    }
}

export const setAuthTagImpl = function (authTag) {
    return function (decipher) {
        return function (errorWrapper) {
            return function (successWrapper) {
                return function () {
                    try {
                        decipher.setAuthTag(authTag)
                        return successWrapper({})
                    }
                    catch (error) {
                        return errorWrapper(error)
                    }
                }
            }
        }
    }
}
