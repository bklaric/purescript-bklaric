import * as pg from "pg"

export const _create = (poolConfig) => () => new pg.Pool(poolConfig)

export const totalCount = (pool) => () => pool.totalCount

export const idleCount = (pool) => () => pool.idleCount

export const waitingCount = (pool) => () => pool.waitingCount

export const connect = (pool) => () =>
    pool.connect().then((client) => ({
        client,
        // The same release function twice: called with no argument it
        // recycles the client, called with true it destroys the connection.
        releaseClient: () => client.release(),
        destroyClient: () => client.release(true)
    }))

export const end = (pool) => () => pool.end()
