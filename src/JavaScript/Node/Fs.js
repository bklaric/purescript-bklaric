import * as fs from 'fs';


export const _readFileSync = (left) => (right) => (path) => (options) => () => {
    try {
        return right(fs.readFileSync(path, options))
    }
    catch (error) {
        return left(error)
    }
}

export const _writeFileSync = (path) => (data) => () => fs.writeFileSync(path, data)

export const mkdirSync = (path) => (options) => () => fs.mkdirSync(path, options)

export const rmSync = (path) => (options) => () => fs.rmSync(path, options)
