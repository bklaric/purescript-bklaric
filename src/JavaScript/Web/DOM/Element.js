export const _getBoundingClientRect = (element) => () => {
    const rect = element.getBoundingClientRect()
    return rect
}

export const _getAttribute = (attribute) => (element) => () => element.getAttribute(attribute)

export const _setAttribute = (name) => (value) => (element) => () => element.setAttribute(name, value)

export const _removeAttribute = (attribute) => (element) => () => element.removeAttribute(attribute)

export const _innerHtml = (element) => () => element.innerHTML

export const _setInnerHtml = (html) => (element) => () => element.innerHTML = html

export const _outerHtml = (element) => () => element.outerHTML

export const _setOuterHtml = (html) => (element) => () => element.outerHTML = html

export const _insertAdjacentHTML = (position) => (html) => (element) => () =>
    element.insertAdjacentHTML(position, html)

export const _insertAdjacentElement = (position) => (adjacentElement) => (element) => () =>
    element.insertAdjacentElement(position, adjacentElement)

export const _replaceWith = (node) => (element) => () => element.replaceWith(node)

export const _scrollWidth = (element) => () => element.scrollWidth

export const _scrollHeight = (element) => () => element.scrollHeight

export const _scrollTop = (element) => () => element.scrollTop

export const _scrollLeft = (element) => () => element.scrollLeft

export const _setScrollTop = (scroll) => (element) => () => element.scrollTop = scroll

export const _setScrollLeft = (scroll) => (element) => () => element.scrollLeft = scroll

export const _scrollBy = (scrollX) => (scrollY) => (element) => () => element.scrollBy(scrollX, scrollY)

export const _querySelector = (selector) => (element) => () => element.querySelector(selector)

export const _querySelectorAll = (selector) => (element) => () => element.querySelectorAll(selector)

export const _closest = (selector) => (element) => () => element.closest(selector)

export const _id = (element) => () => element.id

export const _setId = (id) => (element) => () => element.id = id

export const _setClassName = (className) => (element) => () => element.className = className

export const _className = (element) => () => element.className

export const _classList = (element) => () => element.classList

export const _remove = (element) => () => element.remove()

export const _children = (element) => () => element.children

export const _replaceChildren = (left) => (right) => (nodes) => (element) => () => {
    try {
        return right(element.replaceChildren(...nodes))
    }
    catch (ex) {
        return left(ex)
    }
}

export const _nextElementSibling = (element) => () => element.nextElementSibling

export const _previousElementSibling = (element) => () => element.previousElementSibling

export const _parentElement = (element) => () => element.parentElement

export const _tagName = (element) => () => element.tagName

export const _getElementsByClassName = (class_) => (element) => () => element.getElementsByClassName(class_)

export const _shadowRoot = (element) => () => element.shadowRoot
