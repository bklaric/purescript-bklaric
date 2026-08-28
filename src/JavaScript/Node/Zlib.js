import * as zlib from "zlib"

export const gzipSyncImpl = function (input) {
    return function () {
        return zlib.gzipSync(input)
    }
}
