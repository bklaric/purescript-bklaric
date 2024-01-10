export function add(token) {
    return function (tokenList) {
        return function () {
            tokenList.add(token)
        }
    }
}

export function remove(token) {
    return function (tokenList) {
        return function () {
            tokenList.remove(token)
        }
    }
}
