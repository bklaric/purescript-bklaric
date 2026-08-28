export const _new = (blobParts) => (options) => () => new Blob(blobParts, options)

export const type_ = (blob) => blob.type

export const size = (blob) => blob.size
