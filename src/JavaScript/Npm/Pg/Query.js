export const defaultQuery = (queryString) => (queryParameters) => (querier) => () =>
    querier.query(queryString, queryParameters)

export const _queryWithConfig = (queryConfig) => (querier) => () =>
    querier.query(queryConfig)
