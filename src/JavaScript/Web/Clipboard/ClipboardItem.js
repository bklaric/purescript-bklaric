const _new = (data) => new ClipboardItem(data)

export { _new as new }

// Each Promise is a cold thunk, so it is started here and the item holds the running one.
export const fromPromises = (data) => () =>
    new ClipboardItem(Object.fromEntries(Object.entries(data).map(([type, promise]) => [type, promise()])))
