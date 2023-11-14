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
