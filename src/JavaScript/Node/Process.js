export const _lookupEnv = (variableName) => () => process.env[variableName]

export const env = () => process.env

export const exit = (code) => () => process.exit(code)

export const _onSignal = (signal) => (handler) => () =>
    process.on(signal, function () {
        handler()
    })

export const onUncaughtException = (handler) => () =>
    process.on('uncaughtException', function (error) {
        handler(error)()
    })

export const onUnhandledRejection = (handler) => () =>
    process.on('unhandledRejection', function (reason) {
        handler(reason)()
    })
