import * as postmark from "postmark"

export const create = (serverKey) => () => new postmark.ServerClient(serverKey)

export const _sendEmail = (message) => (errorCallback) => (successCallback) => (client) => () =>
    client.sendEmail(message, function (error, result) {
        if (error) {
            errorCallback(error)()
        }
        else {
            successCallback(result)()
        }
    })
