import * as zlib from "zlib"

export const _gzipSync = (input) => () => zlib.gzipSync(input)
