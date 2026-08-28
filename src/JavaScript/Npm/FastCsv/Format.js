import * as format from "@fast-csv/format"

export function writeToString(options) {
    return function (rows) {
        return function () {
            return format.writeToString(rows, options)
        }
    }
}
