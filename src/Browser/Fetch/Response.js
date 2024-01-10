"use strict";

export function status(response) {
    return response.status
}

export function text(successCallback) {
    return function (response) {
        return function () {
            response.text().then(
                function (body) { successCallback(body)() }
            )
        }
    }
}

export function jsonImpl(successCallback) {
    return function (errorCallback) {
        return function (response) {
            return function () {
                response.json().then(
                    function (body) { successCallback(body)() },
                    function (error) { errorCallback(error)() }
                )
            }
        }
    }
}

export function clone(response) {
    return function () {
        return response.clone()
    }
}
