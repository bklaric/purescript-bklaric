export function fetchImpl(url) {
    return function (options) {
        return function (optionTransforms) {
            return function (successCallback) {
                return function (errorCallback) {
                    return function () {
                        const transformedOptions = {
                            method: options.method && optionTransforms.methodToString(options.method),
                            headers: options.headers,
                            body: options.body,
                            credentials: options.credentials && optionTransforms.credentialsToString(options.credentials)
                        }
                        fetch(url, transformedOptions).then(
                            function (response) { successCallback(response)() },
                            function (error) { errorCallback(error)() }
                        )
                    }
                }
            }
        }
    }
}

export function fetchPromiseImpl(url) {
    return function (options) {
        return function (optionTransforms) {
            return function () {
                const transformedOptions = {
                    method: options.method && optionTransforms.methodToString(options.method),
                    headers: options.headers,
                    body: options.body,
                    credentials: options.credentials && optionTransforms.credentialsToString(options.credentials)
                }
                return fetch(url, transformedOptions)
            }
        }
    }
}
