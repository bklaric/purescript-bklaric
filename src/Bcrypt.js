import * as bcrypt from "bcrypt"

export const _genSalt = (rounds) => (minor) => (errorCallback) => (successCallback) => () =>
    bcrypt.genSalt(rounds, minor, function (error, salt) {
        if (error) {
            errorCallback(error)()
        }
        else {
            successCallback(salt)()
        }
    })

export const _hash = (data) => (saltOrRounds) => (errorCallback) => (successCallback) => () =>
    bcrypt.hash(data, saltOrRounds, function (error, hash) {
        if (error) {
            errorCallback(error)()
        }
        else {
            successCallback(hash)()
        }
    })

export const _compare = (data) => (encrypted) => (errorCallback) => (successCallback) => () =>
    bcrypt.compare(data, encrypted, function (error, result) {
        if (error) {
            errorCallback(error)()
        }
        else {
            successCallback(result)()
        }
    })

export const getRounds = (encrypted) => bcrypt.getRounds(encrypted)
