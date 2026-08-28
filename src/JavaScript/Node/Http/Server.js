import * as http from "http"

export const _createServer = (options) => (callback) => () => http.createServer(options, callback)
