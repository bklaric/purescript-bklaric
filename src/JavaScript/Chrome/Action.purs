module JavaScript.Chrome.Action where

import Prelude

import Effect (Effect)
import Foreign (Foreign)
import JavaScript.Chrome.Shared.Event (Event)
import JavaScript.Chrome.Tabs.Tab (Tab)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import Prim.Row (class Union)
import Untagged.Castable (class Castable, cast)
import Untagged.Union (type (|+|), UndefinedOr)
import Yoga.JSON (class WriteForeign, write)

foreign import _setBadgeText :: Foreign -> Promise Error Unit

setBadgeText :: forall details details'.
    WriteForeign (Record details) => Union details details' (tabId :: Int, text :: String) =>
    Record details -> Promise Error Unit
setBadgeText details = _setBadgeText (write details)

setBadgeText_ :: String -> Promise Error Unit
setBadgeText_ text = setBadgeText {text}

-- | Either a CSS colour string ("#d80032") or an [r, g, b, a] array, as the two
-- | forms Chrome accepts for a badge colour.
type BadgeColor = String |+| Array Int

foreign import _setBadgeBackgroundColor :: {color :: BadgeColor, tabId :: UndefinedOr Int} -> Promise Error Unit

setBadgeBackgroundColor :: forall details. Castable details {color :: BadgeColor, tabId :: UndefinedOr Int} =>
    details -> Promise Error Unit
setBadgeBackgroundColor = _setBadgeBackgroundColor <<< cast

setBadgeBackgroundColor_ :: String -> Promise Error Unit
setBadgeBackgroundColor_ color = setBadgeBackgroundColor {color}

foreign import _setBadgeTextColor :: {color :: BadgeColor, tabId :: UndefinedOr Int} -> Promise Error Unit

setBadgeTextColor :: forall details. Castable details {color :: BadgeColor, tabId :: UndefinedOr Int} =>
    details -> Promise Error Unit
setBadgeTextColor = _setBadgeTextColor <<< cast

setBadgeTextColor_ :: String -> Promise Error Unit
setBadgeTextColor_ color = setBadgeTextColor {color}

foreign import onClicked :: Event "action.onClicked" ((Tab -> Effect Unit) -> Effect Unit)
