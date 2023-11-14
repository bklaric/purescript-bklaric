export const lookupEnvImpl = function (variableName) {
    return function () {
        return process.env[variableName]
    }
}
