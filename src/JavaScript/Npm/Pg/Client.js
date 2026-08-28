import * as pg from "pg"

export const _create = (clientConfig) => () => new pg.Client(clientConfig)

export const connect = (client) => () => client.connect().then(function () { })

export const end = (client) => () => client.end()
