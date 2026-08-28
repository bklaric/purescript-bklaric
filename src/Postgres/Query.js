export const _query = (queryString) => (queryParameters) => (errorCallback) => (successCallback) => (querier) => () =>
    querier.query(
        queryString,
        queryParameters,
        function (error, result) {
            if (error) {
                errorCallback(error)()
            }
            else {
                successCallback(result)()
            }
        }
    )

export const _queryWithConfig = (queryConfig) => (errorCallback) => (successCallback) => (querier) => () =>
    querier.query(
        queryConfig,
        function (error, result) {
            if (error) {
                errorCallback(error)()
            }
            else {
                successCallback(result)()
            }
        }
    )
