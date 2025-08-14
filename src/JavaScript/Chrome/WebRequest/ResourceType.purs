module JavaScript.Chrome.WebRequest.ResourceType where

import Literals (StringLit)
import Untagged.Union (type (|+|))

-- https://developer.mozilla.org/en-US/docs/Mozilla/Add-ons/WebExtensions/API/webRequest/ResourceType

type ResourceType
    =   StringLit "beacon"
    |+| StringLit "csp_report"
    |+| StringLit "font"
    |+| StringLit "image"
    |+| StringLit "imageset"
    |+| StringLit "main_frame"
    |+| StringLit "media"
    |+| StringLit "object"
    |+| StringLit "object_subrequest"
    |+| StringLit "ping"
    |+| StringLit "script"
    |+| StringLit "speculative"
    |+| StringLit "stylesheet"
    |+| StringLit "sub_frame"
    |+| StringLit "web_manifest"
    |+| StringLit "websocket"
    |+| StringLit "xml_dtd"
    |+| StringLit "xmlhttprequest"
    |+| StringLit "xslt"
    |+| StringLit "other"
