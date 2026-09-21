export const status = (response) => response.status

export const text = (response) => () => response.text()

export const json = (response) => () => response.json()

export const blob = (response) => () => response.blob()

export const arrayBuffer = (response) => () => response.arrayBuffer()

export const ok = (response) => response.ok

export const statusText = (response) => response.statusText

export const headers = (response) => response.headers
