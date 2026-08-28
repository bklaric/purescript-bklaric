export const typeString = (record) => () => record.type

export const target = (record) => () => record.target

export const addedNodes = (record) => () => record.addedNodes

export const removedNodes = (record) => () => record.removedNodes

export const _nextSibling = (record) => () => record.nextSibling

export const _previousSibling = (record) => () => record.previousSibling

export const _attributeName = (record) => () => record.attributeName

export const _attributeNamespace = (record) => () => record.attributeNamespace

export const _oldValue = (record) => () => record.oldValue
