export const _key = (keyboardEvent) => keyboardEvent.key

export const _code = (keyboardEvent) => keyboardEvent.code

export const _altKey = (keyboardEvent) => keyboardEvent.altKey

export const _ctrlKey = (keyboardEvent) => keyboardEvent.ctrlKey

export const _shiftKey = (keyboardEvent) => keyboardEvent.shiftKey

export const _metaKey = (keyboardEvent) => keyboardEvent.metaKey

export const _repeat = (keyboardEvent) => keyboardEvent.repeat

export const _getModifierState = (key) => (keyboardEvent) => keyboardEvent.getModifierState(key)
