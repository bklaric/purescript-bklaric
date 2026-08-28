export const lookupEnvImpl = function (variableName) {
    return function () {
        return process.env[variableName]
    }
}

export function env() {
    return process.env
}

export function exit(code) {
    return function () {
        process.exit(code)
    }
}

export const onSignalImpl = function (signal) {
    return function (handler) {
        return function () {
            process.on(signal, function () {
                handler()
            })
        }
    }
}

export const onUncaughtException = function (handler) {
    return function () {
        process.on('uncaughtException', function (error) {
            handler(error)()
        })
    }
}

export const onUnhandledRejection = function (handler) {
    return function () {
        process.on('unhandledRejection', function (reason) {
            handler(reason)()
        })
    }
}
