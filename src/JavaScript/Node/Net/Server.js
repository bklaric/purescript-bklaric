export const _listen = (listenOptions) => (listeningListener) => (server) => () =>
    server.listen(listenOptions, listeningListener)

export const _listenTcp = (port) => (host) => (backlog) => (listeningListener) => (server) => () =>
    server.listen(port, host, backlog, listeningListener)

export const _listenIpc = (path) => (backlog) => (listeningListener) => (server) => () =>
    server.listen(path, backlog, listeningListener)
