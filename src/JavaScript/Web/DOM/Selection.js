export const isCollapsed = (selection) => () => selection.isCollapsed

export const rangeCount = (selection) => () => selection.rangeCount

export const _getRangeAt = (index) => (selection) => () =>
    index < selection.rangeCount ? selection.getRangeAt(index) : null
