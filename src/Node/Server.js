export const listenImpl = function (listenOptions) {
    return function (listeningListener) {
        return function (server) {
            return function () {
                server.listen(listenOptions, listeningListener)
            }
        }
    }
}
