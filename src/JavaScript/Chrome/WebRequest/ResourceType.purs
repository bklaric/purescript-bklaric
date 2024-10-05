module JavaScript.Chrome.WebRequest.ResourceType where

import Prelude

import Foreign (unsafeToForeign)
import Yoga.JSON (class WriteForeign)

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/ResourceType

data ResourceType
    = Beacon
    | CspReport
    | Font
    | Image
    | Imageset
    | MainFrame
    | Media
    | Object
    | ObjectSubrequest
    | Ping
    | Script
    | Speculative
    | Stylesheet
    | SubFrame
    | WebManifest
    | Websocket
    | XmlDtd
    | XmlHttpRequest
    | Xslt
    | Other

toString :: ResourceType -> String
toString Beacon = "beacon"
toString CspReport = "csp_report"
toString Font = "font"
toString Image = "image"
toString Imageset = "imageset"
toString MainFrame = "main_frame"
toString Media = "media"
toString Object = "object"
toString ObjectSubrequest = "object_subrequest"
toString Ping = "ping"
toString Script = "script"
toString Speculative = "speculative"
toString Stylesheet = "stylesheet"
toString SubFrame = "sub_frame"
toString WebManifest = "web_manifest"
toString Websocket = "websocket"
toString XmlDtd = "xml_dtd"
toString XmlHttpRequest = "xmlhttprequest"
toString Xslt = "xslt"
toString Other = "other"

instance WriteForeign ResourceType where
    writeImpl = toString >>> unsafeToForeign
