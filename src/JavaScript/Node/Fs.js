import * as fs from 'fs';


export function readFileSyncImpl(left) {
    return function (right) {
        return function (path) {
            return function (options) {
                return function () {
                    try {
                        return right(fs.readFileSync(path, options))
                    }
                    catch (error) {
                        return left(error)
                    }
                }
            }
        }
    }
}
