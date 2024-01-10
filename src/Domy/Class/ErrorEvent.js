"use strict";

export function messageDefault(event) {
    return event.message
}

export function filenameDefault(event) {
    return event.filename
}

export function linenoDefault(event) {
    return event.lineno
}

export function colnoDefault(event) {
    return event.colno
}

export function errorDefault(event) {
    return event.error
}
