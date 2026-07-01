// `export const undefined = undefined` is a TDZ self-reference under Node's native ESM loader
// (the local `undefined` shadows the global, so the RHS reads it before initialization and throws
// "Cannot access 'undefined' before initialization"). Assign through an intermediate binding — whose
// RHS resolves to the global `undefined` — then re-export it under the name the FFI import expects,
// à la Yoga.JSON's `export const _undefined = undefined`.
const _undefined = undefined
export { _undefined as undefined }
