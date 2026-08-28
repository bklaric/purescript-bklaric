export const _preventDefault = (event) => () => event.preventDefault()

export const _stopPropagation = (event) => () => event.stopPropagation()

export const _stopImmediatePropagation = (event) => () => event.stopImmediatePropagation()

export const _target = (event) => event.target

export const _isTrusted = (event) => event.isTrusted
