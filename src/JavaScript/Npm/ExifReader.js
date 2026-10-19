import ExifReader from 'exifreader'

export const _load = (left) => (right) => (buffer) => (options) => () => {
    try {
        return right(ExifReader.load(buffer, options))
    }
    catch (ex) {
        return left(ex)
    }
}
