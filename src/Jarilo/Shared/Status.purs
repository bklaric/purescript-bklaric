module Jarilo.Shared.Status (class StatusCode, statusCode) where

import Jarilo.Types (BadRequest, Forbidden, Internal, NoContent, NotAuthorized, NotFound, Ok, Status)
import Type.Proxy (Proxy)

-- | A status's code, and the label its response goes under in a route's
-- | response variant, on the server and in the browser alike.
class StatusCode (status :: Status) (label :: Symbol) | status -> label where
    statusCode :: Proxy status -> Int

instance StatusCode Ok "ok" where
    statusCode _ = 200

instance StatusCode NoContent "noContent" where
    statusCode _ = 204

instance StatusCode BadRequest "badRequest" where
    statusCode _ = 400

instance StatusCode NotAuthorized "notAuthorized" where
    statusCode _ = 401

instance StatusCode Forbidden "forbidden" where
    statusCode _ = 403

instance StatusCode NotFound "notFound" where
    statusCode _ = 404

instance StatusCode Internal "internal" where
    statusCode _ = 500
