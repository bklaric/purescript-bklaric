export function value(select) {
    return function () {
        return select.value
    }
}

export function setValue(value) {
    return function (select) {
        return function () {
            select.value = value
        }
    }
}
