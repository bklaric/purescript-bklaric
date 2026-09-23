import * as sgMail from '@sendgrid/mail'

export const setApiKey = (key) => () => sgMail.setApiKey(key)

// The mail service's own client, not the @sendgrid/client singleton.
export const setBaseUrl = (url) => () => sgMail.client.setDefaultRequest('baseUrl', url)

// sgMail.send resolves with [response, body]. Nothing downstream reads either,
// and surfacing them would tie the signature to the client's response shape,
// so the result is dropped and only success/failure crosses the boundary.
export const send = (message) => () => sgMail.send(message).then(() => {})
