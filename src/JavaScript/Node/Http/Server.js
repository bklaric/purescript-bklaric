import * as http from "http"

export const createServerImpl = function (options) {
    return function (callback) {
        return function () {
            return http.createServer(options, callback)
        }
    }
}
