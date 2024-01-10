export function getBoundingClientRectDefault(element) {
    return function () {
        const rect = element.getBoundingClientRect()
        return rect
    }
}

export function getAttributeDefaultImpl(attribute) {
    return function (element) {
        return function () {
            return element.getAttribute(attribute)
        }
    }
}

export function removeAttributeDefault(attribute) {
    return function (element) {
        return function () {
            return element.removeAttribute(attribute)
        }
    }
}

export function innerHtmlDefault(element) {
    return function () {
        return element.innerHTML
    }
}

export function setInnerHtmlDefault(html) {
    return function (element) {
        return function () {
            element.innerHTML = html
        }
    }
}

export function outerHtmlDefault(element) {
    return function () {
        return element.outerHTML
    }
}

export function setOuterHtmlDefault(html) {
    return function (element) {
        return function () {
            element.outerHTML = html
        }
    }
}

export function scrollWidthDefault(element) {
    return function () {
        return element.scrollWidth
    }
}

export function scrollHeightDefault(element) {
    return function () {
        return element.scrollHeight
    }
}

export function scrollTopDefault(element) {
    return function () {
        return element.scrollTop
    }
}

export function scrollLeftDefault(element) {
    return function () {
        return element.scrollLeft
    }
}

export function setScrollTopDefault(scroll) {
    return function (element) {
        return function () {
            element.scrollTop = scroll
        }
    }
}

export function setScrollLeftDefault(scroll) {
    return function (element) {
        return function () {
            element.scrollLeft = scroll
        }
    }
}

export function querySelectorImpl(selector) {
    return function (element) {
        return function () {
            return element.querySelector(selector)
        }
    }
}

export function querySelectorAllDefault(selector) {
    return function (element) {
        return function () {
            return element.querySelectorAll(selector)
        }
    }
}

export function idDefault(element) {
    return function () {
        return element.id
    }
}

export function setIdDefault(id) {
    return function (element) {
        return function () {
            element.id = id
        }
    }
}

export function setClassNameDefault(className) {
    return function (element) {
        return function () {
            return element.className = className
        }
    }
}

export function classNameDefault(element) {
    return function () {
        return element.className
    }
}

export function classListDefault(element) {
    return function () {
        return element.classList
    }
}

export function removeDefault(element) {
    return function () {
        return element.remove()
    }
}

export function childrenDefault(element) {
    return function () {
        return element.children
    }
}
