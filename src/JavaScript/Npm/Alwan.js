import Alwan from 'alwan';

export const _new = (reference) => (config) => () => new Alwan(reference, config)

export const _on = (event) => (callback) => (alwan) => () => alwan.on(event, ev => callback(ev)())
