module JavaScript.Web.DOM.HtmlElements.HtmlVideoElement where

import Prelude

import Data.Maybe (Maybe)
import Effect (Effect)
import JavaScript.Error (Error)
import JavaScript.Promise (Promise)
import JavaScript.Web.DOM.Class (class Element, class EventTarget, class HtmlElement, class Node)
import JavaScript.Web.DOM.Utils (unsafeReadProtoTagged)

foreign import data HtmlVideoElement :: Type

instance EventTarget HtmlVideoElement

instance Node HtmlVideoElement

instance Element HtmlVideoElement

instance HtmlElement HtmlVideoElement

readHtmlVideoElement :: forall object. object -> Maybe HtmlVideoElement
readHtmlVideoElement = unsafeReadProtoTagged "HTMLVideoElement"

foreign import src :: HtmlVideoElement -> Effect String
foreign import setSrc :: String -> HtmlVideoElement -> Effect Unit

-- | Removes the `src` attribute. Followed by `load`, it stops the element's download and playback.
foreign import removeSrc :: HtmlVideoElement -> Effect Unit

foreign import currentSrc :: HtmlVideoElement -> Effect String

foreign import poster :: HtmlVideoElement -> Effect String

foreign import videoWidth :: HtmlVideoElement -> Effect Int
foreign import videoHeight :: HtmlVideoElement -> Effect Int

-- | 0 (`HAVE_NOTHING`) to 4 (`HAVE_ENOUGH_DATA`); 2 (`HAVE_CURRENT_DATA`) and up has a frame to show.
foreign import readyState :: HtmlVideoElement -> Effect Int

foreign import muted :: HtmlVideoElement -> Effect Boolean
foreign import setMuted :: Boolean -> HtmlVideoElement -> Effect Unit

foreign import setLoop :: Boolean -> HtmlVideoElement -> Effect Unit

foreign import setAutoplay :: Boolean -> HtmlVideoElement -> Effect Unit

foreign import setPlaysInline :: Boolean -> HtmlVideoElement -> Effect Unit

foreign import currentTime :: HtmlVideoElement -> Effect Number
foreign import setCurrentTime :: Number -> HtmlVideoElement -> Effect Unit

foreign import duration :: HtmlVideoElement -> Effect Number

foreign import paused :: HtmlVideoElement -> Effect Boolean

foreign import seeking :: HtmlVideoElement -> Effect Boolean

-- | Rejects when playback isn't allowed (the autoplay policy) or the source can't play.
foreign import play :: HtmlVideoElement -> Promise Error Unit

foreign import pause :: HtmlVideoElement -> Effect Unit

foreign import load :: HtmlVideoElement -> Effect Unit

-- | 0 to 1.
foreign import volume :: HtmlVideoElement -> Effect Number
foreign import setVolume :: Number -> HtmlVideoElement -> Effect Unit

foreign import playbackRate :: HtmlVideoElement -> Effect Number
foreign import setPlaybackRate :: Number -> HtmlVideoElement -> Effect Unit

-- | The `buffered` time ranges, in seconds.
foreign import buffered :: HtmlVideoElement -> Effect (Array {start :: Number, end :: Number})

foreign import disablePictureInPicture :: HtmlVideoElement -> Effect Boolean

-- | Rejects where picture-in-picture isn't allowed or supported.
foreign import requestPictureInPicture :: HtmlVideoElement -> Promise Error Unit
