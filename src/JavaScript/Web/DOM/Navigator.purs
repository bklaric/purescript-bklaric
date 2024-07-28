module JavaScript.Web.DOM.Navigator where

import Effect (Effect)
import JavaScript.Web.Clipboard.Clipboard (Clipboard)

foreign import data Navigator :: Type

foreign import userAgent :: Navigator -> Effect String

foreign import language :: Navigator -> Effect String

foreign import languages :: Navigator -> Effect (Array String)

foreign import clipboard :: Navigator -> Effect (Clipboard)
