export const _isConnected = (node) => () => node.isConnected

export const _parentElement = (node) => () => node.parentElement

export const _appendChild = (child) => (node) => () => node.appendChild(child)

export const _textContent = (node) => () => node.textContent

export const _setTextContent = (string) => (node) => () => node.textContent = string

export const _insertBefore = (new_) => (reference) => (node) => () => node.insertBefore(new_, reference)

export const _cloneNode = (deep) => (node) => () => node.cloneNode(deep)

export const _hasChildNodes = (node) => () => node.hasChildNodes()

export const _firstChild = (node) => () => node.firstChild

export const _lastChild = (node) => () => node.lastChild
