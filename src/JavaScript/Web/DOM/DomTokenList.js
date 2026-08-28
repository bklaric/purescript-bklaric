export const add = (token) => (tokenList) => () => tokenList.add(token)

export const remove = (token) => (tokenList) => () => tokenList.remove(token)
