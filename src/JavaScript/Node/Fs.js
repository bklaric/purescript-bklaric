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

export function writeFileSyncImpl(path) {
    return function (data) {
        return function () {
            fs.writeFileSync(path, data)
        }
    }
}

export function mkdirSync(path) {
    return function (options) {
        return function () {
            fs.mkdirSync(path, options)
        }
    }
}

export function rmSync(path) {
    return function (options) {
        return function () {
            fs.rmSync(path, options)
        }
    }
}
