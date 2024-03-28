export function getElementsByClassNameDefault(class_) {
    return function (element) {
        return function () {
            return element.getElementsByClassName(class_)
        }
    }
}
