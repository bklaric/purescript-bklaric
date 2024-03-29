export const listenImpl = function (listenOptions) {
    return function (listeningListener) {
        return function (server) {
            return function () {
                server.listen(listenOptions, listeningListener)
            }
        }
    }
}

export function listenTcpImpl(port) {
    return function (host) {
        return function (backlog) {
            return function (listeningListener) {
                return function (server) {
                    return function () {
                        server.listen(port, host, backlog, listeningListener)
                    }
                }
            }
        }
    }
}

export function listenIpcImpl(path) {
    return function (backlog) {
        return function (listeningListener) {
            return function (server) {
                return function () {
                    server.listen(path, backlog, listeningListener)
                }
            }
        }
    }
}
