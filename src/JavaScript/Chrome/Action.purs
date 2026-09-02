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

foreign import _clearBadgeText :: Int -> Promise Error Unit

-- | Removes a tab's badge text override, so that tab shows the global badge
-- | again. This is what Chrome does for a `null` text with a `tabId`, and it is
-- | the only way to undo a per-tab badge: setting the tab's text to `""` leaves
-- | the override in place, and a per-tab override wins over the global value --
-- | so a tab blanked that way *hides* a global badge rather than falling back to
-- | it. Only the text can be removed this way; a per-tab colour with no text is
-- | not displayed, and a per-tab title is undone by setting it back to the
-- | manifest's `default_title`.
clearBadgeText :: Int -> Promise Error Unit
clearBadgeText = _clearBadgeText

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

foreign import _setTitle :: Foreign -> Promise Error Unit

-- | The toolbar tooltip. Given a `tabId` it applies to that tab alone, which is
-- | what lets a per-tab title sit over the manifest's `default_title` without
-- | replacing it everywhere.
setTitle :: forall details details'.
    WriteForeign (Record details) => Union details details' (tabId :: Int, title :: String) =>
    Record details -> Promise Error Unit
setTitle details = _setTitle (write details)

setTitle_ :: String -> Promise Error Unit
setTitle_ title = setTitle {title}

foreign import onClicked :: Event "action.onClicked" ((Tab -> Effect Unit) -> Effect Unit)
