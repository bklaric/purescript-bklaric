var Pool = require('pg').Pool

export const _create = (poolConfig) => () => new Pool(poolConfig)

export const totalCount = (pool) => () => pool.totalCount

export const idleCount = (pool) => () => pool.idleCount

export const waitingCount = (pool) => () => pool.waitingCount

export const _connect = (errorCallback) => (successCallback) => (pool) => () =>
    pool.connect(function (error, client, releaseClient) {
        if (error) {
            errorCallback(error)()
        }
        else {
            // The same release function twice: called with no
            // argument it recycles the client, called with true it
            // destroys the connection.
            successCallback(client)(releaseClient)(function () {
                releaseClient(true)
            })()
        }
    })

export const end = (callback) => (pool) => () => pool.end(callback)
