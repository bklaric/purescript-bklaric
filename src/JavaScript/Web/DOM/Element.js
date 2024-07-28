export function _getBoundingClientRect(element) {
    return function () {
        const rect = element.getBoundingClientRect()
        return rect
    }
}

export function _getAttribute(attribute) {
    return function (element) {
        return function () {
            return element.getAttribute(attribute)
        }
    }
}

export function _removeAttribute(attribute) {
    return function (element) {
        return function () {
            return element.removeAttribute(attribute)
        }
    }
}

export function _innerHtml(element) {
    return function () {
        return element.innerHTML
    }
}

export function _setInnerHtml(html) {
    return function (element) {
        return function () {
            element.innerHTML = html
        }
    }
}

export function _outerHtml(element) {
    return function () {
        return element.outerHTML
    }
}

export function _setOuterHtml(html) {
    return function (element) {
        return function () {
            element.outerHTML = html
        }
    }
}

export function _insertAdjacentHTML(position) {
    return function (html) {
        return function (element) {
            return function () {
                element.insertAdjacentHTML(position, html)
            }
        }
    }
}

export function _replaceWith(node) {
    return function (element) {
        return function () {
            element.replaceWith(node)
        }
    }
}

export function _scrollWidth(element) {
    return function () {
        return element.scrollWidth
    }
}

export function _scrollHeight(element) {
    return function () {
        return element.scrollHeight
    }
}

export function _scrollTop(element) {
    return function () {
        return element.scrollTop
    }
}

export function _scrollLeft(element) {
    return function () {
        return element.scrollLeft
    }
}

export function _setScrollTop(scroll) {
    return function (element) {
        return function () {
            element.scrollTop = scroll
        }
    }
}

export function _setScrollLeft(scroll) {
    return function (element) {
        return function () {
            element.scrollLeft = scroll
        }
    }
}

export function _querySelector(selector) {
    return function (element) {
        return function () {
            return element.querySelector(selector)
        }
    }
}

export function _querySelectorAll(selector) {
    return function (element) {
        return function () {
            return element.querySelectorAll(selector)
        }
    }
}

export function _id(element) {
    return function () {
        return element.id
    }
}

export function _setId(id) {
    return function (element) {
        return function () {
            element.id = id
        }
    }
}

export function _setClassName(className) {
    return function (element) {
        return function () {
            return element.className = className
        }
    }
}

export function _className(element) {
    return function () {
        return element.className
    }
}

export function _classList(element) {
    return function () {
        return element.classList
    }
}

export function _remove(element) {
    return function () {
        return element.remove()
    }
}

export function _children(element) {
    return function () {
        return element.children
    }
}
