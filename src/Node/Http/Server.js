import * as http from "http"

export const createImpl = function (requestListener) {
    return function () {
        return http.createServer(function (request, response) {
            requestListener(request)(response)()
        })
    }
}
