module JavaScript.Web.Crypto.Subtle (CryptoKey, importJwk, verify) where

import Foreign (Foreign)
import JavaScript.ArrayBuffer (ArrayBuffer)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Yoga.JSON (class WriteForeign, write)

-- https://developer.mozilla.org/en-US/docs/Web/API/SubtleCrypto

foreign import data CryptoKey :: Type

foreign import _importKey :: forall keyData. String -> keyData -> Foreign -> Boolean -> Array String -> Promise Error CryptoKey

-- | Imports a JSON Web Key. `algorithm` is the algorithm's import params, such as
-- | `{name: "ECDSA", namedCurve: "P-256"}`, and `usages` are key usages such as `"verify"`.
importJwk :: forall jwk algorithm. WriteForeign jwk => WriteForeign algorithm =>
    jwk -> algorithm -> Boolean -> Array String -> Promise Error CryptoKey
importJwk jwk algorithm extractable usages = _importKey "jwk" (write jwk) (write algorithm) extractable usages

foreign import _verify :: Foreign -> CryptoKey -> ArrayBuffer -> ArrayBuffer -> Promise Error Boolean

-- | Resolves with whether `signature` is a valid signature of `data'`. ECDSA signatures are the raw
-- | concatenation of r and s (IEEE P1363), not the DER encoding that OpenSSL and Node produce by default.
verify :: forall algorithm. WriteForeign algorithm =>
    algorithm -> CryptoKey -> ArrayBuffer -> ArrayBuffer -> Promise Error Boolean
verify algorithm key signature data' = _verify (write algorithm) key signature data'
