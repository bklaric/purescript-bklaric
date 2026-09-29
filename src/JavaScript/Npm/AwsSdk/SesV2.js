import { SESv2Client, SendEmailCommand } from "@aws-sdk/client-sesv2"

export const newClient = (config) => () => new SESv2Client(config)

const utf8 = (data) => ({ Data: data, Charset: "UTF-8" })

export const sendEmail = (params) => (client) => () =>
    client
        .send(new SendEmailCommand({
            FromEmailAddress: params.fromEmailAddress,
            Destination: { ToAddresses: params.toAddresses },
            Content: {
                Simple: {
                    Subject: utf8(params.subject),
                    Body: { Text: utf8(params.text), Html: utf8(params.html) },
                },
            },
        }))
        // The response carries only the message id, which nothing here reads.
        .then(function () { })
