export const _new = (left) => (right) => (url) => (options) => () => {
    try {
        return right(new Worker(url, options))
    }
    catch (error) {
        return left(error)
    }
}

export const _postMessage = (message) => (worker) => () => worker.postMessage(message)

export const terminate = (worker) => () => worker.terminate()
