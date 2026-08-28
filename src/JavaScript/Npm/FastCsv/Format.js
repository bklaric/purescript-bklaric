import * as format from "@fast-csv/format"

export const writeToString = (options) => (rows) => () => format.writeToString(rows, options)
