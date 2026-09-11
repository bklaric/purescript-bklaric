import * as sgMail from '@sendgrid/mail'

export const setApiKey = (key) => () => sgMail.setApiKey(key)

// sgMail.send resolves with [response, body]. Nothing downstream reads either,
// and surfacing them would tie the signature to the client's response shape,
// so the result is dropped and only success/failure crosses the boundary.
export const send = (message) => () => sgMail.send(message).then(() => {})
