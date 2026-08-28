import * as pg from "pg"

export const _create = (clientConfig) => () => new pg.Client(clientConfig)

export const _connect = (callback) => (client) => () =>
    client.connect(function (error) {
        callback(error ? error : null)()
    })

export const _end = (callback) => (client) => () =>
    client.end(function (error) {
        callback(error ? error : null)()
    })
